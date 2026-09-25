#!/usr/bin/env bash
# Check the illustration toolkit.
. "$(dirname "$(readlink -f "$0")")/../../../lib/check.sh"

section "Krita"
pkg krita
pkg krita-plugin-gmic

section "Tablet support"
pkg libwacom
tablets=$(libwacom-list-local-devices 2>/dev/null | grep -E '^\s*name' | sed 's/.*name: *//' || true)
if [[ -n $tablets ]]; then
  while read -r t; do info "detected tablet: $t"; done <<<"$tablets"
else
  info "no drawing tablet detected right now (plug it in and rerun)"
fi

section "Helpers"
pkg eyedropper
pkg inkscape

summary
