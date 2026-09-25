#!/usr/bin/env bash
# Run Blender with Arch's Python (not Homebrew's), so numpy/glTF work from a terminal too.
# Usage: blender.sh [any blender args]   e.g. blender.sh -b --factory-startup -P mockup.py -- --image a.png
. "$(dirname "$(readlink -f "$0")")/../../../lib/env.sh"
exec blender "$@"
