# Contributing

Contributions that add reproducible, well-sourced filament presets are welcome.

## Requirements

1. Use an official manufacturer product page or technical data sheet whenever
   one exists.
2. State the printer, nozzle diameter, hotend flow class, plate, and material.
3. Keep manufacturer defaults separate from measured per-spool calibration.
4. Use conservative maximum volumetric speed unless a source or repeatable
   calibration supports a higher value.
5. Preserve all safety and compatibility restrictions from the Bambu system
   profile, particularly for flexible and abrasive materials.
6. Run ./scripts/validate.sh before submitting a change.

## Privacy and portability

Never commit:

- Bambu Studio .info synchronization files;
- account IDs, access codes, device serial numbers, LAN credentials, or tokens;
- absolute home-directory paths;
- personal names or email addresses;
- cloud setting_id, base_id, or locally generated filament_id values.

The profile JSON should contain only portable slicer settings. Repository
commits should use an identity the contributor is comfortable publishing.

## Adding a profile

Place the file under:

~~~text
profiles/<printer-vendor>/<printer>/<nozzle-hotend>/<filament-vendor>/
~~~

Then add the relative path and basic metadata to manifest.json, document the
official source in docs/SOURCES.md, and update the table in README.md.

## Pull-request checklist

- [ ] JSON and repository validation pass.
- [ ] Manufacturer source is official and directly linked.
- [ ] No personal or device-specific data is present.
- [ ] No unverified personal flow/PA value is presented as universal.
- [ ] Compatibility warnings and direct-drive requirements are retained.
- [ ] Changes and test conditions are explained.
