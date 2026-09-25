---
name: 3d-modeling
description: 3D modeling, materials, lighting, rendering and animation with Blender 5.2 LTS on codeonym's Arch workstation (AMD Vega iGPU — EEVEE on GPU, Cycles on CPU). Use when the user wants to model something in 3D, make product/packaging/device mockups of their designs, render stills or turntables, create 3D assets for the web (glTF/GLB for three.js / React Three Fiber), convert between 3D formats, prepare STL for 3D printing, or script Blender with Python.
---

# 3D modeling (Blender 5.2)

## Toolkit on this machine

| Tool | Use it for | Launch / CLI |
|---|---|---|
| **Blender 5.2 LTS** | Modeling, sculpting, materials, lighting, rendering, animation, compositing, video sequencing | `blender` (from the app grid) · terminal: `scripts/blender.sh` |
| **EEVEE** (real-time) | Fast renders on the Vega iGPU — mockups, previews, stylized work | engine `BLENDER_EEVEE` |
| **Cycles** (path tracing) | Photoreal renders — **CPU only here** (Vega APUs aren't supported by HIP), use denoising + low samples | engine `CYCLES` |
| Bundled add-ons | Node Wrangler, Rigify, glTF 2.0, FBX, OBJ/STL/PLY importers | *Edit → Preferences → Add-ons / Get Extensions* |
| `/usr/bin/ffmpeg` | Encode rendered frames to MP4 with AMD VAAPI | used by `render.sh` |

**Machine quirk:** Homebrew's `python3` (from `~/.zshrc`) hijacks Blender's embedded Python when Blender is launched *from a terminal* → numpy missing → glTF import/export errors. Launching from the GNOME app grid is fine. From a terminal use `scripts/blender.sh …` (all scripts here already fix PATH).

## Scripts

| Script | What it does |
|---|---|
| `check.sh` | Blender version, Cycles GPU availability, engines, bundled add-ons, VAAPI for animations |
| `blender.sh [args]` | Blender with the PATH fix above — use instead of `blender` in a terminal |
| `render.sh scene.blend [--engine eevee\|cycles] [--samples N] [--res WxH] [--frame N \| --anim]` | Headless still or animation render; animations become an MP4 automatically |
| `mockup.py` | Your 2D design (poster, cover, card, screenshot) as a lit 3D studio mockup. `blender.sh -b --factory-startup -P mockup.py -- --image design.png --out mockup.png [--style tilt\|flat\|lean] [--bg '#f4f4f5'] [--save mockup.blend]` |
| `turntable.py` | 360° turntable of any model (glb/obj/fbx/stl/blend) with studio lighting. `blender.sh -b --factory-startup -P turntable.py -- --model chair.glb --save chair-tt.blend` then `render.sh chair-tt.blend --anim` |
| `convert-model.sh in.X out.Y [--draco]` | Converts between blend/glb/gltf/obj/fbx/stl/ply; `--draco` shrinks GLB for the web |

## Guides

- `references/blender-essentials.md` — navigation, the modeling toolkit, modifiers, shortcuts that matter.
- `references/materials-lighting-render.md` — Principled BSDF, HDRI/studio lighting, EEVEE vs Cycles settings tuned for this machine.
- `references/project-recipes.md` — step-by-step: product mockup, low-poly scene, logo in 3D, web asset for React Three Fiber, 3D print prep.

## Rules of thumb

1. Model at real-world scale (1 unit = 1 m) and apply scale (Ctrl+A → Scale) before modifiers/export.
2. Keep modifiers live (Subdivision, Bevel, Mirror, Solidify) until export — non-destructive like the 2D tools.
3. Preview in EEVEE, final in EEVEE unless you need true glass/caustics/GI → then Cycles with denoising at 64–256 samples.
4. Render animations as PNG frames (crash-safe), encode to MP4 afterwards (`render.sh --anim` does this).
5. For the web, export GLB with Draco, keep textures ≤ 2K, and < 50k triangles per hero model.
