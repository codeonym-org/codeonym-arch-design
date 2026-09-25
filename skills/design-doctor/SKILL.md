---
name: design-doctor
description: Health check and map of codeonym's whole creative toolkit on Arch Linux (graphic design, illustration, photo, UI, typography, print, Blender 3D, video editing, screen recording). Use when the user asks what design tools they have, whether everything is installed and working, which tool or skill fits a creative task, why a design tool misbehaves from the terminal (Homebrew shadowing ffmpeg/perl/python), or wants install commands for anything missing.
---

# Design doctor

## Run it
```bash
bash <skill-dir>/scripts/doctor.sh            # one-screen summary
bash <skill-dir>/scripts/doctor.sh --verbose  # every check in detail
```
It runs every skill's `check.sh`, lists anything missing with ready-to-paste `pacman`/`yay` commands, flags **PATH shadowing** (Homebrew tools hiding the Arch ones) and **disk space**.

## Which skill for which job

| I want to… | Skill | Main tools |
|---|---|---|
| Logo, banner, social post, thumbnail, icon, batch resize/compress images | `graphic-design` | Inkscape, GIMP (+G'MIC, Resynthesizer), ImageMagick |
| Draw, paint, concept art, comics, hand-drawn assets | `illustration` | Krita (+G'MIC) |
| Edit / grade / batch photos, strip GPS, upscale | `photo-editing` | darktable, GIMP, Upscayl, exiftool |
| App/website mockups, design system, favicons & app icons, color palettes | `ui-design` | Lunacy, Penpot/Figma (browser), Inkscape, Eyedropper |
| Choose/pair/install fonts, specimens, web fonts | `typography` | Font Manager, FontForge, fontconfig |
| Flyer, poster, brochure, business card, print-ready PDF, preflight | `print-layout` | Scribus, Ghostscript, Poppler |
| 3D models, product/design mockups, renders, turntables, web 3D (GLB), 3D print | `3d-modeling` | Blender 5.2 (EEVEE GPU / Cycles CPU) |
| Edit videos, export for platforms, loudness, GIFs, thumbnails | `video-editing` | Kdenlive, melt, ffmpeg (VAAPI) |
| Record tutorials/demos, OBS scenes & plugins, keystrokes, zoom effects | `screen-recording` | OBS + plugins, showmethekey, OpenScreen |

## Cross-skill pipelines
- **Brand kit**: `typography` (pick fonts) → `ui-design/palette.sh` (colors) → `graphic-design` (logo in Inkscape, `svg-export.sh`) → `ui-design/icon-set.sh` (favicons) → `print-layout` (business card) → `3d-modeling/mockup.py` (presentation shots).
- **Tutorial video**: `screen-recording` (record, `finish-recording.sh`) → `video-editing` (Kdenlive edit, `encode.sh`) → `video-editing/thumbs.sh` + `graphic-design` (thumbnail) → `video-editing/gif.sh` (README loop).
- **Portfolio piece**: `3d-modeling/turntable.py` or `mockup.py` → `render.sh --anim` → `video-editing/encode.sh web` → `graphic-design/optimize.sh` for stills.

## Known machine facts
- GNOME 50 on Wayland; AMD Radeon Vega 8 iGPU (VAAPI H.264/HEVC encode; no Cycles GPU); 8 CPU threads.
- Homebrew is loaded in `~/.zshrc` and shadows `ffmpeg`, `ffprobe`, `perl`, `python3`, `cwebp`. All skill scripts source `lib/env.sh` to put `/usr/bin` first. `doctor.sh` prints a one-line `~/.zshrc` fix for your whole shell.
