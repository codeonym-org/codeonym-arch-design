---
name: illustration
description: Digital painting and illustration with Krita 6 (+ G'MIC plugin) on codeonym's Arch workstation — concept art, character/scene illustration, hand-drawn icons and textures, sketches for logos, comics and storyboards. Use when the user wants to draw or paint, set up brushes or a drawing tablet, build a Krita canvas/template, animate frame-by-frame, or batch-export .kra files.
---

# Illustration (Krita)

## Toolkit on this machine

| Tool | Use it for | Launch / CLI |
|---|---|---|
| **Krita 6** | Painting, sketching, inking, comics, 2D frame animation | `krita` · headless export `krita in.kra --export --export-filename out.png` |
| **G'MIC for Krita** | Filters, colorize line art, artistic looks | Krita → *Filter → Start G'MIC-Qt* |
| **Inkscape** | Turning finished line art into clean vectors | `graphic-design` skill → `vectorize.sh` |
| **Eyedropper** | Sample colors from references anywhere on screen | `eyedropper` |
| **libwacom** + GNOME Settings | Tablet pressure, mapping, buttons | *Settings → Wacom Tablet* (appears when a tablet is plugged in) |

## Scripts

| Script | What it does |
|---|---|
| `check.sh` | Verifies Krita, G'MIC plugin, tablet support; lists detected tablets |
| `new-canvas.sh <preset> <name>` | Creates a ready-to-paint `.kra` from a preset (`a4-300`, `square-4k`, `wallpaper-4k`, `thumbnail`, `comic-page`) |
| `kra-export.sh <file.kra…> [png\|jpg\|webp]` | Batch-exports Krita files headlessly into `export/` |

## Guides

- `references/krita-workflow.md` — setup, brushes, layer structure, sketch → line → flats → shading → finish.
- `references/tablet-setup.md` — pressure curves and button mapping under GNOME Wayland.

## Quick defaults

- Canvas: work at 2× the final size, 300 DPI for print, sRGB-elle-V2-srgbtrc profile for screen.
- Save `.kra` often (Krita autosaves every 15 min — set 5 in *Settings → Configure Krita → General → File Handling*).
- Keep reference images in a *Reference Images* tool board (the tool with the pin icon), not on canvas layers.
- Export for web via `kra-export.sh`, then run the `graphic-design` skill's `optimize.sh`.
