# Manufacturer sources

Sources were checked on 2026-09-03. Values are paraphrased; follow the linked
manufacturer document and the label on the exact spool if guidance changes.

## Anycubic

### PETG and PETG Translucent

- [PETG product page](https://store.anycubic.com/products/petg-filament)
- [PETG technical data sheet](https://cdn.shopify.com/s/files/1/0698/1235/5357/files/ANYCUBIC_TDS_PETG_V3.0.pdf?v=1757584046)
- [PETG Translucent product page](https://eu.anycubic.com/collections/materials/products/petg-translucent)

Published baseline: 230-250 C nozzle, 60-70 C bed, 12 mm3/s maximum
volumetric speed, 1.23 g/cm3 density, 0.96 extrusion multiplier, 90% fan, and
55-65 C drying for 6-8 hours. The translucent preset uses a conservative
10 mm3/s limit.

### PETG-CF

- [PETG-CF product page](https://uk.anycubic.com/products/petg-cf-filament)
- [PETG-CF technical data sheet](https://cdn.shopify.com/s/files/1/0245/5519/2380/files/ANYCUBIC_TDS_PETG-CF_V3.0.pdf?v=1773715720)

Published baseline: 240-270 C nozzle, 65-75 C bed, 11 mm3/s maximum
volumetric speed, 1.32 g/cm3 density, 0.98 extrusion multiplier, 60% fan,
40 mm/s retraction speed, hardened nozzle, and 60-65 C drying for 6-8 hours.

## eSUN

- [PLA+ product page](https://www.esun3d.com/pla-pro-product)
- [PLA+HS product page](https://www.esun3d.com/eplahs-product/)
- [ePLA-Matte product page](https://www.esun3d.com/epla-matte-product)
- [eSilk-PLA product page](https://www.esun3d.com/esilk-pla-product)
- [Bambu-specific fast-filament parameters](https://www.esun3d.com/uploads/eSUN-Fast-filaments-print-parameters.pdf)

The Bambu-specific table pairs ePLA-Matte with 230 C, flow ratio 0.98, and
22 mm3/s. PLA+ uses 220 C and flow ratio 0.98; this repository keeps a
conservative 20 mm3/s. The PLA+HS profile uses 225 C with the documented
22 mm3/s starting point. eSilk-PLA uses the provider density of 1.21 g/cm3
and a deliberately conservative 7.5 mm3/s.

## SUNLU

- [TPU 95A product page](https://www.sunlu.com/products/267)
- [TPU 95A technical data sheet](https://media.sunlu.com/prod/20260330/e8b9c06a-4b93-46cb-9532-d9deb185a7c8.pdf?filename=TDS)

Published baseline: 190-230 C nozzle depending on speed, 50-60 C bed,
1.21 g/cm3 density, 0.8-1.2 mm retraction, and 30-40 mm/s retraction speed.
The profile uses 225 C, a 55 C bed, 0.8 mm at 30 mm/s, and the X2D
direct-drive main extruder restriction inherited from Generic TPU.
