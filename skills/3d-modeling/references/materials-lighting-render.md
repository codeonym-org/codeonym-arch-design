# Materials, lighting & rendering (tuned for this machine)

## Materials (Principled BSDF)
Shading workspace. With **Node Wrangler** enabled: select the BSDF, **Ctrl+Shift+T** loads a whole PBR texture set (color/roughness/normal) in one go.

| Material | Base Color | Metallic | Roughness | Other |
|---|---|---|---|---|
| Matte plastic | any | 0 | 0.5 | |
| Glossy plastic | any | 0 | 0.15 | Coat 0.3 |
| Brushed aluminium | #C8C8CC | 1 | 0.35 | Anisotropic 0.5 |
| Gold | #F5C66A | 1 | 0.2 | |
| Glass | white | 0 | 0 | Transmission 1, IOR 1.45 (Cycles best) |
| Rubber | #202020 | 0 | 0.8 | |
| Fabric | any | 0 | 0.9 | Sheen 0.5 |
| Screen / emissive | image | 0 | 0.1 | Emission color = image, strength 1–3 |

Free PBR textures and HDRIs: ambientCG, Poly Haven (CC0).

## Lighting setups
- **Studio (product)**: 3 area lights — key (large, 45° side, strongest), fill (opposite, 30 % of key), rim (behind, to separate from background) + a curved backdrop (plane, extrude back edge up, bevel the corner). `mockup.py` and `turntable.py` build exactly this.
- **HDRI**: World → Color → *Environment Texture* → open `.hdr`/`.exr` from Poly Haven. Fast realism; rotate with a Mapping node.
- **Sun + sky** (outdoor): Sun light (strength 3–5) + World *Sky Texture*.

## Color management
Render → Color Management → View Transform **AgX** (default, handles bright lights gracefully), Look *Medium High Contrast* for punchier product shots.

## EEVEE on the Vega iGPU
- Render samples 32–64; enable *Raytracing* (Render properties) for reflections; *Shadows → Resolution* higher for crisp contact shadows.
- Keep resolution at 1920×1080 for stills; 4K works but takes memory — the iGPU shares system RAM.
- Great for: mockups, stylized/low-poly, motion graphics, previews.

## Cycles on CPU
- Device CPU (automatic here). Samples **64–256** + **Denoise: OpenImageDenoise** — low samples + denoiser is the key to acceptable CPU times.
- *Light Paths → Max Bounces* 4–6 for most scenes (glass: raise Transmission to 8).
- Use *Render Region* (Ctrl+B in camera view) to test a small area.
- Overnight/long renders: `bash scripts/render.sh scene.blend --engine cycles --samples 128 --anim`.

## Output
- Stills: PNG 16-bit (or EXR for compositing), then export JPEG/WebP via the `graphic-design` skill's `optimize.sh`.
- Animation: PNG frames → MP4 (handled by `render.sh --anim`, VAAPI H.264). Or bring frames/MP4 into Kdenlive (`video-editing` skill).
- Transparent background: Render → Film → *Transparent* ✔ (PNG RGBA) — perfect for placing 3D renders into Inkscape/GIMP layouts.
