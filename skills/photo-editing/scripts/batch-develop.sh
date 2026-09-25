#!/usr/bin/env bash
# Headless darktable export, optionally applying a saved style.
# Usage: batch-develop.sh <style-name|-> photo1.raf photo2.jpg ...
#   style-name: name of a style in ~/.config/darktable/styles (without .dtstyle), or '-' for none.
# Env: FORMAT=jpg|tif|png|webp (default jpg), WIDTH=0 (0 = full size)
set -euo pipefail
. "$(dirname "$(readlink -f "$0")")/../../../lib/env.sh"
[[ $# -ge 2 ]] || { echo "usage: $0 <style-name|-> <photos...>" >&2; exit 2; }

style=$1; shift
fmt=${FORMAT:-jpg}; width=${WIDTH:-0}

# Separate config dir so a running darktable GUI doesn't lock the library.
cfg=$(mktemp -d)
trap 'rm -rf "$cfg"' EXIT
if [[ $style != - ]]; then
  src_style="$HOME/.config/darktable/styles/$style.dtstyle"
  [[ -f $src_style ]] || { echo "style not found: $src_style" >&2; exit 1; }
  mkdir -p "$cfg/styles"; cp "$src_style" "$cfg/styles/"
fi

for f in "$@"; do
  [[ -f $f ]] || { echo "skip $f"; continue; }
  out="$(dirname "$f")/export"
  mkdir -p "$out"
  dst="$out/$(basename "${f%.*}").$fmt"
  args=("$f")
  [[ -f $f.xmp ]] && args+=("$f.xmp")     # reuse edits already made in the GUI
  args+=("$dst" --width "$width" --height 0 --hq true --upscale false)
  [[ $style != - ]] && args+=(--style "$style")
  darktable-cli "${args[@]}" --core --configdir "$cfg" >/dev/null 2>&1 \
    && echo "✔ $dst" || echo "✘ $f failed"
done
