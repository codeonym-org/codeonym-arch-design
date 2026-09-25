#!/usr/bin/env bash
# Check Blender and its render setup on this machine.
. "$(dirname "$(readlink -f "$0")")/../../../lib/check.sh"

section "Blender"
pkg blender
bin blender

section "Render devices"
report=$(blender -b --factory-startup --python-expr '
import bpy
p = bpy.context.preferences.addons["cycles"].preferences
for t in ("HIP", "ONEAPI", "CUDA", "OPTIX"):
    try:
        p.compute_device_type = t
        p.get_devices()
        names = [d.name for d in p.devices if d.type == t]
        print("DEV", t, ", ".join(names) if names else "-")
    except Exception:
        print("DEV", t, "-")
print("ENG", ",".join(bpy.types.RenderSettings.bl_rna.properties["engine"].enum_items.keys()))
' 2>/dev/null | grep -E '^(DEV|ENG) ')
gpu=$(awk '$1=="DEV" && $3!="-" {print $2": "substr($0, index($0,$3))}' <<<"$report")
if [[ -n $gpu ]]; then info "Cycles GPU: $gpu"; else info "Cycles GPU: none — Cycles renders on CPU ($(nproc) threads); use EEVEE for fast previews"; fi
info "engines: $(awk '$1=="ENG" {print $2}' <<<"$report"),CYCLES"
info "GPU (EEVEE/viewport): $(lspci 2>/dev/null | grep -Ei 'vga|3d' | sed 's/.*: //' | head -1)"

section "Add-ons shipped with Blender"
ver=$(blender --version 2>/dev/null | awk 'NR==1{print $2}' | cut -d. -f1,2)
for a in node_wrangler rigify io_scene_gltf2 io_scene_fbx cycles; do
  if [[ -d /usr/share/blender/$ver/scripts/addons_core/$a ]]; then info "$a"; else warn "$a not found"; fi
done
info "More add-ons: Edit → Preferences → Get Extensions (extensions.blender.org)"

section "Video encoding for animations"
if /usr/bin/ffmpeg -hide_banner -encoders 2>/dev/null | grep -q h264_vaapi; then
  info "/usr/bin/ffmpeg has h264_vaapi (AMD hardware encode)"
else
  warn "/usr/bin/ffmpeg without VAAPI"
fi

summary
