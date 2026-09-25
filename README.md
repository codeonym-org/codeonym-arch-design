# codeonym-arch-design

My personal Claude Code skills for my design workstation: Arch Linux, GNOME 50 on Wayland, AMD Radeon Vega 8 iGPU. Each skill knows the tools installed on this machine, has scripts that check them, and has step-by-step guides for the way I build designs, videos and 3D work with them.

This is part of my own setup, not a general-purpose toolkit. The versions, quirks (Homebrew shadowing system tools, CPU-only Cycles, VAAPI H.264/HEVC only), OBS layout and hotkeys are specific to my machine. It's public so it's easy to install and reference, and you're welcome to read or fork it, but expect to adapt it.

## Skills

| Skill | Covers |
|---|---|
| `codeonym-arch-design:design-doctor` | One health check for everything, which-skill-for-which-job map, PATH/disk warnings |
| `codeonym-arch-design:graphic-design` | GIMP 3.2 (+G'MIC, Resynthesizer), Inkscape 1.4, ImageMagick, optimizers |
| `codeonym-arch-design:illustration` | Krita 6 (+G'MIC), tablet setup |
| `codeonym-arch-design:photo-editing` | darktable 5.6, GIMP retouching, Upscayl, exiftool |
| `codeonym-arch-design:ui-design` | Lunacy, Penpot/Figma, design tokens, icon sets, palettes |
| `codeonym-arch-design:typography` | Installed font library, Font Manager, FontForge, specimens, web fonts |
| `codeonym-arch-design:print-layout` | Scribus 1.6, bleed/CMYK, PDF preflight, compression, proofs |
| `codeonym-arch-design:3d-modeling` | Blender 5.2: mockups, turntables, headless renders, format conversion |
| `codeonym-arch-design:video-editing` | Kdenlive, melt, ffmpeg with VAAPI, loudness, GIFs, platform presets |
| `codeonym-arch-design:screen-recording` | OBS 32 + plugins, showmethekey, OpenScreen, presenter mode, my "Pro Studio" OBS setup |

## Install
```bash
claude plugin marketplace add codeonym-org/codeonym-arch-design
claude plugin install codeonym-arch-design@codeonym
```

## Updating
Edit in my working copy (`~/workstation/codeonym-arch-design`), bump `version` in `.claude-plugin/plugin.json`, commit and push, then:
```bash
claude plugin marketplace update codeonym
claude plugin update codeonym-arch-design@codeonym
```
Restart Claude Code to load the new version.

## Layout
```
.claude-plugin/     plugin.json + marketplace.json
lib/                check.sh (shared check helpers), env.sh (prefer /usr/bin over Homebrew)
skills/<name>/      SKILL.md · scripts/ · references/
```

## Quick start
```bash
bash skills/design-doctor/scripts/doctor.sh
```
