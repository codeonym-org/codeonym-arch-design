---
name: ui-design
description: UI/UX and web/app interface design on codeonym's Arch workstation with Lunacy 14 (desktop, opens .fig/.sketch), Penpot and Figma in the browser, Inkscape for icons, and Eyedropper for color picking. Use when the user wants wireframes, app or website mockups, a design system (colors, type scale, spacing tokens), favicons/app icons/PWA icons, or wants to hand designs off to a Next.js/Tailwind codebase.
---

# UI design (Lunacy · Penpot · Inkscape)

## Toolkit on this machine

| Tool | Use it for | Launch |
|---|---|---|
| **Lunacy 14** (desktop) | Figma-style editor that works offline; opens `.fig` and `.sketch`; built-in icon/photo/illustration libraries | `lunacy` |
| **Penpot** (browser) | Open-source, SVG-native, great dev handoff (CSS/SVG inspect) | https://design.penpot.app |
| **Figma** (browser) | When a client/team already uses Figma | https://figma.com |
| **Inkscape 1.4** | Custom icons and illustrations to import as SVG | `inkscape` |
| **Eyedropper** | Pick and convert colors (HEX/RGB/HSL/OKLCH) from anywhere on screen | `eyedropper` |
| **Fonts** | Inter, IBM Plex, Source Sans/Serif, Roboto, Fira, JetBrains Mono installed | see `typography` skill |

## Scripts

| Script | What it does |
|---|---|
| `check.sh` | Verifies Lunacy, Inkscape, Eyedropper, UI fonts; checks that Penpot/Figma are reachable |
| `icon-set.sh <icon.svg> [outdir]` | Generates favicon.ico, favicon.svg, apple-touch-icon, PWA icons (192/512 + maskable), Android/desktop sizes, and a `site.webmanifest` + HTML snippet |
| `palette.sh <#hex> [name]` | Builds a 50–950 tint/shade scale from one brand color → CSS variables, Tailwind v4 `@theme` block, and a swatch PNG |

## Guides

- `references/ui-workflow.md` — brief → wireframe → design system → hi-fi → prototype → handoff.
- `references/design-tokens.md` — spacing/type/radius scales and how to carry them into Next.js + Tailwind.

## Rules of thumb

1. Start grayscale and low-fi; add brand color only after layout and hierarchy work.
2. 8-pt spacing grid (4 for tight UI), 12-column layout on desktop, 4 columns on mobile.
3. Build components (buttons, inputs, cards) with variants before assembling screens.
4. Every text/background pair ≥ 4.5:1 contrast (3:1 for large text). Check with the contrast tool in Lunacy/Penpot.
5. Design mobile (390 px) and desktop (1440 px) frames for every key screen.
