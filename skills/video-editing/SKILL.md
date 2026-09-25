---
name: video-editing
description: Video editing and delivery on codeonym's Arch workstation with Kdenlive 26.08 (MLT/melt), ffmpeg 9 with AMD VAAPI hardware encoding (H.264/HEVC on the Vega iGPU), and Blender's Video Sequencer as a backup. Use when the user wants to edit a video (tutorial, demo, vlog, promo, reel), cut/trim/concatenate clips, add titles/subtitles/music, fix or normalize audio, export for YouTube/LinkedIn/Instagram/TikTok/web, make GIFs, pull thumbnails, or render a Kdenlive project from the terminal.
---

# Video editing (Kdenlive · ffmpeg · melt)

## Toolkit on this machine

| Tool | Use it for | Launch / CLI |
|---|---|---|
| **Kdenlive 26.08** | Multi-track editing: cuts, titles, transitions, effects, color, audio mixing, subtitles | `kdenlive` · headless `scripts/render-project.sh` |
| **melt 7.40** (MLT) | Kdenlive's render engine, scriptable | `melt` |
| **ffmpeg 9 (`/usr/bin/ffmpeg`)** | Encode, convert, trim, loudness, GIFs, VAAPI hardware encoding | `/usr/bin/ffmpeg` |
| **Blender VSE** | Backup editor; also for 3D/motion-graphic inserts (`3d-modeling` skill) | Blender → *Video Editing* workspace |
| **OBS** | Recording source footage | `screen-recording` skill |
| **GIMP / Inkscape** | Thumbnails, lower-thirds, title cards as PNG with alpha | `graphic-design` skill |

**Machine quirks**
- Plain `ffmpeg` in your shell is **Homebrew's (no VAAPI)**. Scripts here force `/usr/bin` first; in manual commands type `/usr/bin/ffmpeg`.
- The Vega iGPU hardware-encodes **H.264 and HEVC only** (no AV1 encode, despite `av1_vaapi` being listed).
- Hardware encoding is fast but makes bigger files than x264 at equal quality — use `--sw` in `encode.sh` for the smallest final uploads.

## Scripts

| Script | What it does |
|---|---|
| `check.sh` | Kdenlive, MLT, frei0r effects, ffmpeg builds + VAAPI encoders, shadowing warnings |
| `encode.sh <in> <preset> [out] [--sw]` | Presets: `web`, `youtube`, `vertical` (1080×1920 blurred fill), `square`, `archive` (HEVC), `preview` |
| `loudnorm.sh <in> [--target -14] [--denoise]` | Two-pass EBU R128 loudness normalization (video copied untouched), optional noise reduction |
| `gif.sh <in> [--start S] [--dur D] [--width W] [--fps F]` | Palette-optimized GIF + a far smaller WebM for READMEs/docs |
| `thumbs.sh <in> [count]` | Evenly spaced frame grabs + storyboard sheet for picking a thumbnail |
| `render-project.sh <project.kdenlive> [out.mp4]` | Renders a Kdenlive project with melt, no GUI |

## Guides

- `references/kdenlive-workflow.md` — project setup, proxy clips, the edit (J/K/L, razor, ripple), titles, color, audio, subtitles, render.
- `references/delivery-specs.md` — per-platform specs, loudness targets, and the ffmpeg one-liners worth knowing.

## Rules of thumb

1. Project profile = your footage (usually 1080p 30 or 60 fps). Enable **proxy clips** for 4K or long screen recordings on this iGPU.
2. Story first: rough cut → fine cut → B-roll/zooms → titles → color → audio → export.
3. Audio matters more than video: normalize to **−14 LUFS** (YouTube/social) or **−16 LUFS** (voice/podcast).
4. Keep masters (`archive` preset or Kdenlive lossless), deliver platform versions from them.
5. Burn captions for social (most people watch muted); upload `.srt` separately for YouTube.
