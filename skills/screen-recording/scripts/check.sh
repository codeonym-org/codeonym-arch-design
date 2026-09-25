#!/usr/bin/env bash
# Check the screen-recording setup: OBS, plugins, Wayland capture stack, GPU encoding, helpers.
. "$(dirname "$(readlink -f "$0")")/../../../lib/check.sh"

section "OBS Studio"
pkg obs-studio
pkg obs-studio-plugin-browser

section "OBS plugins (AUR starter pack)"
for p in obs-move-transition obs-advanced-masks obs-composite-blur obs-shaderfilter-git obs-source-clone \
         obs-source-record obs-freeze-filter obs-3d-effect obs-stroke-glow-shadow obs-backgroundremoval \
         obs-pipewire-audio-capture obs-wayland-hotkeys obs-advanced-scene-switcher; do
  pkg "$p" aur
done
builtin_re='^(decklink|frontend-tools|image-source|linux-|obs-ffmpeg|obs-filters|obs-libfdk|obs-nvenc|obs-outputs|obs-qsv11|obs-transitions|obs-vst|obs-webrtc|obs-websocket|obs-x264|rtmp-services|text-freetype2|obs-browser)'
extra=$(find /usr/lib/obs-plugins -maxdepth 1 -name '*.so' -printf '%f\n' 2>/dev/null | sed 's/\.so$//' | sort | grep -vE "$builtin_re" | tr '\n' ' ')
info "third-party plugin libraries loaded by OBS: ${extra:-none}"

section "Wayland capture stack"
info "session: ${XDG_SESSION_TYPE:-?} / ${XDG_CURRENT_DESKTOP:-?}"
pkg pipewire
pkg wireplumber
pkg xdg-desktop-portal-gnome
if systemctl --user is-active --quiet pipewire; then info "pipewire running"; else warn "pipewire not running"; fi

section "GPU encoding"
if [[ $(vainfo 2>/dev/null) == *VAProfileH264High*VAEntrypointEncSlice* ]]; then
  info "VAAPI H.264 encode available → OBS: Output → Recording → Encoder 'FFmpeg VAAPI H.264'"
else
  warn "no VAAPI H.264 encode found (install libva-utils and check mesa)"
fi

section "Presentation helpers"
pkg showmethekey
pkg openscreen aur "(Screen Studio–style auto-zoom recorder)"
info "cursor size: $(gsettings get org.gnome.desktop.interface cursor-size)  ·  locate-pointer (Ctrl ripple): $(gsettings get org.gnome.desktop.interface locate-pointer)"

section "OBS configuration"
cfg=~/.config/obs-studio/basic
info "profiles: $(ls "$cfg/profiles" 2>/dev/null | tr '\n' ' ')"
info "scene collections: $(ls "$cfg/scenes" 2>/dev/null | grep -v '\.bak$' | sed 's/\.json$//' | tr '\n' ' ')"

summary
