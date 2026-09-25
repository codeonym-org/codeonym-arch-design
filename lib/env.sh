#!/usr/bin/env bash
# Prefer Arch system tools. Homebrew (loaded in ~/.zshrc) ships its own ffmpeg (no VAAPI),
# perl (breaks /usr/bin/exiftool) and python3 (Blender then loses numpy → glTF import/export fails).
export CODEONYM_ORIG_PATH=${CODEONYM_ORIG_PATH:-$PATH}
export PATH="/usr/bin:$PATH"

# shadowed <cmd>: prints the path your normal shell would run if it isn't the /usr/bin one.
shadowed() {
  local p
  p=$(PATH=$CODEONYM_ORIG_PATH command -v "$1" 2>/dev/null) || return 1
  [[ $p != /usr/bin/$1 && -x /usr/bin/$1 ]] && echo "$p"
}
