#!/usr/bin/env python3
"""Install a new standalone Bambu Studio material without replacing any preset."""

import argparse
import json
import os
from pathlib import Path
import tempfile
import uuid


def install(profile, filament_dir):
    data = json.loads(profile.read_text(encoding="utf-8"))
    if data.get("inherits") != "" or data.get("from") != "User":
        raise ValueError("Expected a standalone User profile with empty inherits.")
    name = data.get("name")
    if not isinstance(name, str) or not name.strip() or any(c in name for c in '/\\\0') or name in {".", ".."}:
        raise ValueError("Invalid profile name.")
    if data.get("filament_settings_id") != [name]:
        raise ValueError("filament_settings_id must match the profile name.")
    for key in ("filament_vendor", "filament_type", "compatible_printers"):
        values = data.get(key)
        if not isinstance(values, list) or not values or not all(isinstance(v, str) and v.strip() for v in values):
            raise ValueError(f"Missing or invalid {key}.")
    if any(key in data for key in ("filament_id", "user_id", "setting_id", "base_id")):
        raise ValueError("Use a portable template without local or cloud IDs.")
    if filament_dir.name != "filament" or not filament_dir.is_dir():
        raise ValueError("--filament-dir must point to an existing account filament directory.")

    existing_ids = set()
    for path in filament_dir.rglob("*.json"):
        existing = json.loads(path.read_text(encoding="utf-8"))
        if path.stem == name or existing.get("name") == name:
            raise FileExistsError(f"Profile already exists: {name}. Nothing was overwritten.")
        if existing.get("filament_id"):
            existing_ids.add(existing["filament_id"])
    material_id = "P" + uuid.uuid4().hex[:7]
    while material_id in existing_ids:
        material_id = "P" + uuid.uuid4().hex[:7]
    data["filament_id"] = material_id
    payload = json.dumps(data, indent=2, ensure_ascii=False) + "\n"

    directory = filament_dir / "base"
    directory.mkdir(exist_ok=True)
    destination = directory / (name + ".json")
    temporary = None
    try:
        with tempfile.NamedTemporaryFile(mode="w", encoding="utf-8", dir=directory, suffix=".tmp", delete=False) as stream:
            temporary = Path(stream.name)
            stream.write(payload)
            stream.flush()
            os.fsync(stream.fileno())
        # A hard link publishes the complete JSON atomically and fails if the
        # destination exists. Never use replace(), which would overwrite it.
        os.link(temporary, destination)
    finally:
        if temporary is not None:
            temporary.unlink(missing_ok=True)
    return destination


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("profile", type=Path)
    parser.add_argument("--filament-dir", required=True, type=Path)
    args = parser.parse_args()
    try:
        destination = install(args.profile.expanduser(), args.filament_dir.expanduser())
    except (OSError, ValueError) as error:
        parser.exit(1, f"Not installed: {error}\n")
    print(f"Created a separate material: {destination.name}")
    print("Existing presets were not changed. Restart Bambu Studio to load the new material.")


if __name__ == "__main__":
    main()
