---
name: graphic-design
description: Raster and vector graphic design on codeonym's Arch workstation with GIMP 3.2 (+ G'MIC, Resynthesizer), Inkscape 1.4, ImageMagick 7, potrace and the web-image optimizers (pngquant, oxipng, jpegoptim, cwebp, avifenc, cjxl). Use when the user wants to make or edit a logo, banner, social-media post, thumbnail, poster graphic, icon set, or wants to batch-export, resize, convert, vectorize or compress images. Also use when they ask which graphic tool to use for a job.
---

# Graphic design (GIMP · Inkscape · ImageMagick)

## Toolkit on this machine

| Tool | Use it for | Launch / CLI |
|---|---|---|
| **Inkscape 1.4** | Vector: logos, icons, banners, anything that must scale | `inkscape` · headless `inkscape file.svg --export-type=png` |
| **GIMP 3.2** | Raster: photo compositing, retouching, textures, mockups | `gimp` · batch `gimp-console-3.2` |
| **G'MIC-Qt** (GIMP plugin) | 500+ filters: stylize, denoise, sharpen, artistic looks | GIMP → *Filters → G'MIC-Qt* |
| **Resynthesizer** (GIMP plugin) | Content-aware fill / object removal | GIMP → *Filters → Enhance → Heal selection* |
| **ImageMagick 7** | Scripted resize, crop, compose, convert | `magick` |
| **potrace** | Bitmap → SVG tracing (logos from scans) | `potrace` (also Inkscape *Path → Trace Bitmap*) |
| **Optimizers** | Shrink exports for the web | `pngquant`, `oxipng`, `jpegoptim`, `cwebp`, `avifenc`, `cjxl`, GUI: `curtail` |
| **Eyedropper** | Pick colors anywhere on screen (Wayland-safe) | `eyedropper` |
| **Upscayl** | AI upscaling of low-res assets | `upscayl` |

Fonts, color and brand typography live in the `typography` skill; UI mockups in `ui-design`; print-ready PDFs in `print-layout`.

## Pick the right tool

- Must scale, or has few flat colors (logo, icon, badge, diagram) → **Inkscape**, keep the source as SVG.
- Built from photos, textures, painting or effects → **GIMP**, keep the source as `.xcf`.
- Hand-drawn look or painting → the `illustration` skill (Krita).
- Same edit applied to many files → **ImageMagick / scripts below**, never repeat by hand.

## Scripts

All in `scripts/`. Run with `bash <skill-dir>/scripts/<name>`.

| Script | What it does |
|---|---|
| `check.sh` | Verifies GIMP, plugins, Inkscape, ImageMagick, optimizers; prints install commands for anything missing |
| `svg-export.sh <file.svg> [sizes…]` | Exports an SVG to PNGs at several widths (default 512 1024 2048) plus PDF |
| `social-sizes.sh <image> [--fit\|--fill]` | Renders one master image into every common social/banner size |
| `optimize.sh <files…>` | Lossless/near-lossless compression in place-safe copies (`*.opt.*`), plus WebP and AVIF variants |
| `vectorize.sh <bitmap> [threshold%]` | Traces a black-and-white bitmap (scan, sketch logo) into a clean SVG |

## Workflows

Step-by-step guides are in `references/`:

- `references/logo-in-inkscape.md` — design a logo from concept to exported brand kit.
- `references/social-graphics.md` — templates, safe zones and the size table used by `social-sizes.sh`.
- `references/gimp-essentials.md` — GIMP 3 non-destructive workflow, G'MIC, Resynthesizer, export settings.

## Rules of thumb

1. Keep an editable master (`.svg` / `.xcf`) next to every export; exports go in an `export/` folder.
2. Design at the largest size you will need, export down — never scale raster up (use Upscayl if forced).
3. Web exports: PNG only for flat graphics/transparency, otherwise WebP/AVIF with a JPEG fallback. Always run `optimize.sh`.
4. Use colors in sRGB for screens. Print (CMYK) is handled in the `print-layout` skill.
5. Before delivering, look at the export at 100 % and at the real display size.
