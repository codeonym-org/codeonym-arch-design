---
name: print-layout
description: Print and multi-page layout on codeonym's Arch workstation with Scribus 1.6 (flyers, posters, brochures, business cards, CVs, magazines), plus Ghostscript and Poppler for PDF preflight, compression, CMYK conversion and proofs. Use when the user wants something printed or a print-quality PDF — bleed, crop marks, CMYK, PDF/X, paper sizes — or wants to check, shrink or proof a PDF before sending it to a printer or client.
---

# Print layout (Scribus · Ghostscript · Poppler)

## Toolkit on this machine

| Tool | Use it for | Launch / CLI |
|---|---|---|
| **Scribus 1.6** | Page layout with bleed, CMYK colors, master pages, PDF/X export | `scribus` · scripted `scribus -g -ns -py script.py` |
| **Inkscape / GIMP** | Make the artwork (vector / raster) that Scribus places | see `graphic-design` |
| **Ghostscript** | Compress PDFs, convert to CMYK | `gs` |
| **Poppler** | Inspect PDFs: boxes, fonts, image resolution, render proofs | `pdfinfo`, `pdffonts`, `pdfimages`, `pdftoppm` |
| **hunspell-en_us** | Spell-check in Scribus (*Item → Check Spelling*) | — |

## Scripts

| Script | What it does |
|---|---|
| `check.sh` | Verifies Scribus, Ghostscript, Poppler, spell-check, and whether a CMYK press profile is installed |
| `new-print-doc.sh <preset> <name> [--pages N] [--title T] [--font F] [--proof]` | Builds a Scribus `.sla` with correct size, 3 mm bleed, margins, CMYK brand colors and placeholder frames; `--proof` also exports a PDF with crop marks. Presets: `a4 a5 a3 letter business-card dl-flyer square-210 poster-50x70` |
| `pdf-preflight.sh <file.pdf> [--min-dpi 300]` | Checks trim/bleed boxes, embedded fonts, image ppi, color spaces — exits non-zero on problems |
| `pdf-proof.sh <file.pdf> [dpi]` | Renders pages to PNG + an overview sheet to review or send to a client |
| `pdf-compress.sh <in.pdf> [screen\|ebook\|printer\|prepress]` | Shrinks PDFs (ebook ≈ email-friendly) |
| `pdf-cmyk.sh <in.pdf>` | Fallback conversion of all colors to CMYK |

## Guide

- `references/print-workflow.md` — from brief to printer: sizes, bleed, safe zone, color, images, fonts, Scribus export settings, and what to send the printer.

## Rules of thumb

1. **Bleed 3 mm** on every side, background elements extend to the bleed edge; keep text ≥ 5 mm inside the trim (the template's margins handle this).
2. **Images ≥ 300 ppi** at their placed size; vector art (Inkscape PDF/SVG) for logos.
3. **Fonts embedded** or outlined. **Rich black** (C60 M40 Y40 K100) for big dark areas, 100 % K only for small text.
4. **CMYK colors look duller than RGB** — show the client a proof, don't promise screen-bright neon.
5. Always run `pdf-preflight.sh` before sending, and ask the printer for their specs/ICC profile.
