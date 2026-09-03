#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(cd "${script_dir}/.." && pwd)"
manifest="${repo_root}/manifest.json"
profiles_dir="${repo_root}/profiles"

fail()
{
  echo "ERROR: $*" >&2
  exit 1
}

command -v jq >/dev/null 2>&1 || fail "jq is required"

jq empty "${manifest}" || fail "manifest.json is not valid JSON"

manifest_count="$(jq '.profiles | length' "${manifest}")"
profile_count=0

while IFS= read -r profile
do
  relative="${profile#${repo_root}/}"

  jq empty "${profile}" || fail "invalid JSON: ${relative}"

  jq -e '
    (.name | type == "string" and length > 0) and
    (.inherits | type == "string" and length > 0) and
    (.from == "User") and
    (.filament_settings_id | type == "array" and length == 1) and
    (.filament_settings_id[0] == .name) and
    (.filament_vendor | type == "array" and length == 1) and
    (.filament_extruder_variant | type == "array" and length == 6) and
    (.version | type == "string" and length > 0)
  ' "${profile}" >/dev/null || fail "required profile metadata is invalid: ${relative}"

  jq -e '
    (has("user_id") or
     has("setting_id") or
     has("base_id") or
     has("filament_id") or
     has("access_code") or
     has("serial_number")) | not
  ' "${profile}" >/dev/null || fail "private or non-portable identifier in: ${relative}"

  for key in \
    filament_extruder_variant \
    nozzle_temperature \
    nozzle_temperature_initial_layer \
    filament_max_volumetric_speed \
    filament_flow_ratio \
    filament_retraction_length \
    filament_retraction_speed \
    filament_deretraction_speed \
    slow_down_min_speed
  do
    length="$(jq -r --arg key "${key}" '.[$key] | if . == null then 0 else length end' "${profile}")"
    if [ "${length}" -ne 0 ] && [ "${length}" -ne 6 ]; then
      fail "${relative}: ${key} must have six X2D variant values"
    fi
  done

  jq -e --arg path "${relative}" '.profiles | any(.path == $path)' "${manifest}" >/dev/null ||
    fail "profile is not listed in manifest.json: ${relative}"

  profile_count=$((profile_count + 1))
done < <(find "${profiles_dir}" -type f -name '*.json' | LC_ALL=C sort)

[ "${profile_count}" -gt 0 ] || fail "no profiles found"
[ "${profile_count}" -eq "${manifest_count}" ] ||
  fail "manifest lists ${manifest_count} profiles but ${profile_count} files exist"

while IFS= read -r relative
do
  [ -f "${repo_root}/${relative}" ] || fail "manifest path does not exist: ${relative}"
done < <(jq -r '.profiles[].path' "${manifest}")

if find "${repo_root}" -path "${repo_root}/.git" -prune -o -type f -name '*.info' -print | grep -q .; then
  fail "Bambu Studio .info sync metadata must not be committed"
fi

home_root="/Users"
if grep -RInE --exclude-dir=.git "${home_root}/[^/[:space:]]+/" "${repo_root}" >/dev/null; then
  fail "absolute macOS home path detected"
fi

echo "Validated ${profile_count} portable filament profiles."
