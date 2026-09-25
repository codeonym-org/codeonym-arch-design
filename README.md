# codeonym-arch-design

Claude Code skills for a design workstation on Arch Linux (GNOME Wayland, AMD Vega). Each skill knows the tools installed on the machine, has scripts that check them, and has step-by-step guides for building designs with them.

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
| `codeonym-arch-design:screen-recording` | OBS 32 + plugins, showmethekey, OpenScreen, presenter mode |

## Install
```bash
claude plugin marketplace add ~/workstation/codeonym-arch-design
claude plugin install codeonym-arch-design@codeonym
```
After editing skills, run `claude plugin marketplace update codeonym` and reinstall/restart to pick up changes.

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
