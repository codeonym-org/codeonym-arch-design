---
name: screen-recording
description: Professional screen and camera recording on codeonym's Arch workstation (GNOME 50 Wayland, AMD Vega VAAPI) with OBS Studio 32 and its plugin pack (advanced masks, composite blur, shaderfilter, source clone/record, freeze, 3D effect, stroke/glow/shadow, background removal, PipeWire app audio, Wayland hotkeys, advanced scene switcher, move transition), showmethekey for keystroke overlays, OpenScreen for Screen Studio–style auto-zoom demos, and GNOME cursor tweaks. Use when the user wants to record a tutorial, demo, course, talk or stream, set up or configure OBS scenes/profiles/filters, needs zoom-on-click or cursor highlighting, keystroke display, or wants to clean up a finished recording.
---

# Screen recording (OBS · showmethekey · OpenScreen)

## Toolkit on this machine

| Tool | Use it for | Launch |
|---|---|---|
| **OBS Studio 32** | Scenes (screen, cam, screen+cam), filters, recording, streaming | `obs` |
| OBS plugins | see `references/obs-plugins.md` — what each does and how to use it | inside OBS |
| **showmethekey** | On-screen keystroke overlay (Wayland-compatible) — capture its window in OBS | `showmethekey-gtk` |
| **OpenScreen** (AUR `openscreen`) | Auto-zoom on clicks, smooth cursor, backgrounds — polished product demos | `openscreen` |
| **GNOME cursor settings** | Bigger cursor + Ctrl ripple ("locate pointer") | `scripts/presenter-mode.sh` |
| **Kdenlive / ffmpeg** | Editing and delivery | `video-editing` skill |

## Wayland reality check (important)
- OBS captures the screen through **PipeWire + the GNOME portal**: *Screen Capture (PipeWire)* source; GNOME asks which screen/window on first use.
- **Live zoom-follow-mouse inside OBS does not work on Wayland** (plugins/scripts need X11 cursor coordinates; GNOME 50 has no X11 session). Options:
  1. **OpenScreen** — record, then it auto-generates zooms on clicks (Screen Studio style). Best for product demos.
  2. **Manual zooms in OBS** with *Move Transition* (hotkey → animate a zoomed crop of the screen source) — best for live/tutorial flow.
  3. **Zooms in post** in Kdenlive with keyframed *Transform* (see `video-editing` → `kdenlive-workflow.md`).
- Global hotkeys need the **obs-wayland-hotkeys** plugin (uses the GlobalShortcuts portal), otherwise they only work while OBS is focused.

## Scripts

| Script | What it does |
|---|---|
| `check.sh` | OBS + every plugin, PipeWire/portal stack, VAAPI encode, showmethekey/OpenScreen, cursor settings, existing OBS profiles |
| `presenter-mode.sh on [size] \| off \| status` | Bigger cursor + Ctrl ripple for recording; `off` restores your previous settings |
| `finish-recording.sh <rec.mkv> [--trim-start S] [--trim-end S] [--target -14] [--denoise]` | Lossless remux to MP4, trim, loudness normalize, and a small review copy |

## Guides

- `references/obs-setup.md` — the recommended profile (VAAPI, CQP, MKV + auto-remux), scene collection layout, mic filter chain, hotkeys.
- `references/obs-plugins.md` — each installed plugin: what it's for and a concrete recipe.
- `references/recording-workflow.md` — pre-flight checklist, recording technique, and post-production pipeline.

## Rules of thumb

1. Record **MKV** (crash-safe) with *Automatically remux to MP4* on.
2. Encoder: **FFmpeg VAAPI H.264**, CQP 18–20 — the CPU stays free for the apps you demo.
3. Canvas 1920×1080; scale your apps so text is readable at 1080p (VS Code font ≥ 16, browser zoom 125 %).
4. Separate tracks: mic on track 1, desktop audio on track 2 (Advanced audio properties) — fix balance in the edit.
5. Presenter mode on, notifications off (*GNOME → Do Not Disturb*), clean desktop.
