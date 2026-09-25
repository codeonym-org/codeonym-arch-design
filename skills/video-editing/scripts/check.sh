#!/usr/bin/env bash
# Check the video-editing toolkit.
. "$(dirname "$(readlink -f "$0")")/../../../lib/check.sh"

section "Editors"
pkg kdenlive
pkg mlt
pkg frei0r-plugins
bin melt
bin kdenlive_render
pkg blender
info "Blender's Video Sequencer is a capable backup editor (Video Editing workspace)"

section "ffmpeg"
pkg ffmpeg
for f in $(type -ap ffmpeg | sort -u); do
  enc=$("$f" -hide_banner -encoders 2>/dev/null | grep -oE '(h264|hevc|av1)_vaapi' | tr '\n' ' ')
  info "$f → hardware: ${enc:-none}"
done
if sh=$(shadowed ffmpeg); then warn "plain 'ffmpeg' in your shell is $sh (no VAAPI) — scripts here force /usr/bin first"; fi

section "GPU encoding (VAAPI)"
pkg libva-utils
if command -v vainfo >/dev/null; then
  vainfo 2>/dev/null | grep -oE 'VAProfile(H264High|HEVCMain|AV1Profile0)\s*:\s*VAEntrypointEncSlice' |
    awk '{print $1}' | sed 's/VAProfile//' | while read -r p; do info "encode: $p"; done
fi

section "Helpers"
pkg obs-studio
pkg imagemagick
info "Recording & zoom effects: see the screen-recording skill"

summary
