---
name: typography
description: Fonts and typography on codeonym's Arch workstation — the installed font library (Inter, IBM Plex, Source Sans/Serif/Code, Roboto, Open Sans, Fira Code, JetBrains Mono, Noto incl. CJK/emoji, Liberation, DejaVu), Font Manager (incl. Google Fonts browsing), GNOME Fonts, and FontForge. Use when the user wants to choose or pair fonts, see what fonts are installed, install new fonts, compare fonts in a specimen, convert fonts to web formats (WOFF2), or edit/create a font.
---

# Typography (fonts · Font Manager · FontForge)

## Toolkit on this machine

| Tool | Use it for | Launch / CLI |
|---|---|---|
| **Font Manager** | Browse, compare, enable/disable fonts; install Google Fonts directly | `font-manager` |
| **GNOME Fonts** | Quick preview / install a single font file | `gnome-font-viewer` |
| **FontForge** | Edit glyphs, create fonts, convert formats | `fontforge` · scripted `fontforge -lang=py -script` |
| **fontconfig** | List and match installed fonts | `fc-list`, `fc-match` |

### Installed families worth knowing
| Role | Families |
|---|---|
| UI / product sans | **Inter** (variable), **IBM Plex Sans**, Roboto, Open Sans, Source Sans 3 |
| Editorial serif | **Source Serif 4**, IBM Plex Serif, Noto Serif |
| Monospace / code | **JetBrains Mono**, Fira Code, IBM Plex Mono, Source Code Pro |
| Coverage / fallback | Noto Sans/Serif (+ CJK, Emoji, Extra), DejaVu, Liberation (metric-compatible with Arial/Times/Courier) |

## Scripts

| Script | What it does |
|---|---|
| `check.sh` | Verifies font tools and the key families; reports total font count |
| `font-inventory.sh [filter]` | Lists installed families (optionally filtered), with style count and file location |
| `font-specimen.sh "Family A" "Family B" … [-t "sample text"] [-o out.png]` | Renders a side-by-side specimen PNG to compare/pair fonts |
| `webfont.sh <font.ttf\|otf…> [outdir]` | Converts fonts to WOFF2 (+ WOFF) and writes an `@font-face` CSS file |

## Guides

- `references/pairing-and-hierarchy.md` — proven pairings from the installed set, type scale, readability rules.
- `references/installing-fonts.md` — user vs system install, Google Fonts via Font Manager, AUR font packages, licensing.

## Rules of thumb

1. Two families max per project (one sans + one serif **or** mono). Use weights for hierarchy.
2. Body text 16 px+ on screen, line-height 1.5, 60–75 characters per line.
3. Check the license before shipping a font on the web or in a product (OFL = free to embed).
4. For web, self-host WOFF2 (`webfont.sh`) or use `next/font` — never hotlink random font CDNs.
