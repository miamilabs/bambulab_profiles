# Profile format and scope

## Slicing preset versus AMS identity

The JSON files in this repository are Bambu Studio filament slicing presets.
They inherit a printer/nozzle-specific Bambu system preset and override only
the values required for the named filament.

The AMS material-selection dialog uses a separate base-material identity built
around filament_id and setting_id. Consequently, a profile can be visible in
**Prepare > Project Filaments** without appearing as a separate AMS material.
Assign the closest correct material identity to the AMS slot, then select the
nozzle-specific profile in Prepare before slicing.

Relevant upstream implementation:

- [AMS material settings](https://github.com/bambulab/BambuStudio/blob/master/src/slic3r/GUI/AMSMaterialsSetting.cpp)
- [Preset bundle](https://github.com/bambulab/BambuStudio/blob/master/src/libslic3r/PresetBundle.hpp)

This repository intentionally does not distribute .info files or locally
generated AMS/cloud identifiers.

## X2D variant arrays

Variant-specific arrays follow Bambu Studio's X2D order:

1. Direct Drive Standard
2. Direct Drive High Flow
3. Direct Drive E3D High Flow
4. Bowden Standard
5. Bowden High Flow
6. Bowden E3D High Flow

A value validated only for the standard hotend is intentionally repeated for
high-flow variants instead of guessing a higher limit. Run a maximum-flow test
before increasing it.

## Compatibility fields

- filament_printable inherited from Generic TPU keeps TPU off the X2D Bowden
  auxiliary extruder.
- filament_extruder_compatibility on PETG-CF and silk profiles mirrors the
  auxiliary-extruder warning used by Bambu's corresponding X2D profiles.
- required_nozzle_HRC preserves hardened-nozzle requirements for abrasive
  materials.

Compatibility metadata is a guardrail, not a substitute for checking current
printer and filament documentation.

## Calibration policy

Manufacturer extrusion multipliers are suitable starting points. Flow ratio,
pressure advance, and maximum volumetric speed can vary by spool, color,
moisture level, nozzle wear, and printer. Personal calibration results are not
included as shared defaults.
