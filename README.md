# Bambu Lab Filament Profile Reference

[![Validate profiles](https://github.com/miamilabs/bambulab_profiles/actions/workflows/validate.yml/badge.svg)](https://github.com/miamilabs/bambulab_profiles/actions/workflows/validate.yml)

Community-maintained filament presets for Bambu Studio. The initial collection
targets the **Bambu Lab X2D with 0.4 mm standard-flow hotends** and uses current
manufacturer guidance as a conservative starting point.

> [!CAUTION]
> These profiles are provided **as-is**, without warranty. Filament batches,
> printers, hotends, build plates, ambient conditions, and firmware differ.
> You are solely responsible for validating temperatures, flow, cooling,
> clearances, material compatibility, and safe printer operation. The authors
> and contributors are not responsible for failed prints, wasted material,
> equipment or property damage, injury, or any other loss arising from use of
> these files.

This project is independent and is not affiliated with or endorsed by Bambu
Lab or any filament manufacturer named here. Product and company names remain
the property of their respective owners.

## Included profiles

| Manufacturer | Material | Nozzle | Main bed | MVS | Important note |
| --- | --- | ---: | ---: | ---: | --- |
| Anycubic | [PETG](profiles/bambu-lab/x2d/0.4mm-standard/anycubic/petg.json) | 245 C | 70 C | 12 mm3/s | Provider-default cooling |
| Anycubic | [PETG Translucent](profiles/bambu-lab/x2d/0.4mm-standard/anycubic/petg-translucent.json) | 250 C | 70 C | 10 mm3/s | Conservative flow rate |
| Anycubic | [PETG-CF](profiles/bambu-lab/x2d/0.4mm-standard/anycubic/petg-cf.json) | 255 C | 70 C | 11 mm3/s | Hardened nozzle; main extruder preferred |
| eSUN | [PLA+](profiles/bambu-lab/x2d/0.4mm-standard/esun/pla-plus.json) | 220 C | 55 C | 20 mm3/s | Conservative published baseline |
| eSUN | [PLA+HS](profiles/bambu-lab/x2d/0.4mm-standard/esun/pla-plus-hs.json) | 225 C | 55 C | 22 mm3/s | High-speed starting point |
| eSUN | [ePLA-Matte](profiles/bambu-lab/x2d/0.4mm-standard/esun/epla-matte.json) | 230 C | 55 C | 22 mm3/s | eSUN Bambu-specific pairing |
| eSUN | [eSilk-PLA](profiles/bambu-lab/x2d/0.4mm-standard/esun/esilk-pla.json) | 215 C | 55 C | 7.5 mm3/s | Main extruder preferred |
| SUNLU | [TPU 95A](profiles/bambu-lab/x2d/0.4mm-standard/sunlu/tpu-95a.json) | 225 C | 55 C | 6 mm3/s | Direct-drive main extruder only |

The values above were checked against the official sources listed in
[docs/SOURCES.md](docs/SOURCES.md) on 2026-09-03. They are reference starting
points, not certification for every spool.

## Repository layout

~~~text
profiles/
  bambu-lab/x2d/0.4mm-standard/
    anycubic/
    esun/
    sunlu/
docs/
scripts/
.github/workflows/
~~~

Profiles are organized by printer, nozzle/hotend, and filament manufacturer.
They are nozzle-specific **slicing presets**, not AMS base-material records.

## Installation

1. Download the JSON profile appropriate for your printer and hotend.
2. Import it using Bambu Studio's configuration import, or copy it into your
   account's filament directory.
3. Restart Bambu Studio.
4. Select the imported profile in **Prepare > Project Filaments**.
5. Confirm the AMS slot mapping, build plate, nozzle, and filament before
   slicing.

Typical user-profile locations are:

- macOS: <code>~/Library/Application Support/BambuStudio/user/&lt;account&gt;/filament/</code>
- Windows: <code>%APPDATA%\BambuStudio\user\&lt;account&gt;\filament\</code>

The AMS material dialog and the Prepare-tab slicing preset are separate. AMS
stores the spool/material identity; the Prepare-tab profile supplies the
temperature, flow, cooling, and volumetric limits used for slicing. See
[docs/PROFILE_FORMAT.md](docs/PROFILE_FORMAT.md).

## Before printing

- Verify every temperature against the label on your exact spool.
- Run flow-ratio and pressure-advance calibration for each material/color.
- Start with a small test model and watch the first layers.
- Do not treat another user's pressure-advance or flow calibration as universal.
- Keep TPU on the X2D direct-drive main extruder.
- Use a hardened nozzle and appropriate filament path for PETG-CF.

## Validation

Run:

~~~bash
./scripts/validate.sh
~~~

The validator checks JSON syntax, required profile metadata, manifest coverage,
variant-array sizes, accidental sync metadata, and common local-path leaks.
GitHub Actions runs the same validation on every push and pull request.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md). Every profile change should include an
official manufacturer source and clearly identify the supported printer,
nozzle, plate, and hotend type.

## License

Released under the [MIT License](LICENSE). Anyone may use, copy, modify,
distribute, sublicense, or sell copies, subject to the license notice.
