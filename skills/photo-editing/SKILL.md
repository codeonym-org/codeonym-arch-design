---
name: photo-editing
description: Photo development and retouching on codeonym's Arch workstation with darktable 5.6 (RAW/JPEG development, color grading, batch styles), GIMP 3.2 (retouching, compositing), Upscayl (AI upscaling) and exiftool (metadata). Use when the user wants to edit, color-grade, batch-process, upscale, resize for web, or strip location/metadata from photos, or wants a consistent look across a photo set (portfolio, product shots, headshots).
---

# Photo editing (darktable · GIMP · Upscayl)

## Toolkit on this machine

| Tool | Use it for | Launch / CLI |
|---|---|---|
| **darktable 5.6** | Non-destructive development of RAW and JPEG: exposure, color, grading, lens fixes, batch looks | `darktable` · headless `darktable-cli in.jpg [style.xmp] out.jpg` |
| **GIMP 3.2** + Resynthesizer / G'MIC | Pixel retouching: remove objects, skin/spot healing, compositing | `gimp` |
| **Upscayl** | AI 2×/4× upscaling of small or old photos | `upscayl` |
| **exiftool** | Read/strip metadata (GPS!), rename by date | `/usr/bin/perl /usr/bin/vendor_perl/exiftool` — plain `exiftool` breaks here because a Homebrew perl shadows the system one |
| **ImageMagick** | Resize, watermark, contact sheets | `magick` |

## Scripts

| Script | What it does |
|---|---|
| `check.sh` | Verifies darktable, darktable-cli, GIMP, Upscayl, exiftool |
| `batch-develop.sh <style.dtstyle\|-> <photos…>` | Headless darktable export of many photos, optionally applying a saved style, into `export/` |
| `web-ready.sh <photos…> [--max 2048] [--watermark "© codeonym"]` | Resize, sharpen lightly, strip metadata, optional watermark → `web/` |
| `strip-metadata.sh <photos…>` | Removes all metadata (GPS, camera serial) in place, keeps a backup `*_original` unless `--no-backup` |
| `contact-sheet.sh <photos…>` | One JPEG grid of thumbnails to review/share a set |

## Guides

- `references/darktable-workflow.md` — the scene-referred workflow in darktable 5, module order, styles for consistent sets.
- `references/retouching.md` — GIMP retouch recipes (object removal, headshot cleanup, sky replacement).

## Rules of thumb

1. Edit in darktable first (global look), then GIMP only for local pixel fixes — round-trip via *export as TIFF 16-bit*.
2. Never edit originals: darktable stores edits in `.xmp` sidecars; exports go to `export/`.
3. Strip metadata before publishing anything online (`strip-metadata.sh` or `web-ready.sh`).
4. For a consistent set, grade one hero photo, save it as a darktable **style**, apply to the rest (`batch-develop.sh`).
