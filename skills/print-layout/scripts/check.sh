#!/usr/bin/env bash
# Check the print-layout toolkit.
. "$(dirname "$(readlink -f "$0")")/../../../lib/check.sh"

section "Layout"
pkg scribus
pkg hunspell-en_us
if scribus --version &>/dev/null; then info "$(scribus --version 2>/dev/null | tail -1)"; fi

section "PDF tools"
pkg ghostscript
pkg poppler
bin pdfinfo
bin pdffonts
bin pdfimages

section "Color management"
icc=$(find /usr/share/color/icc -iname '*.ic[cm]' 2>/dev/null | wc -l)
info "$icc ICC profile(s) in /usr/share/color/icc"
if ! find /usr/share/color/icc ~/.local/share/icc -iname '*fogra*' -o -iname '*coated*' 2>/dev/null | grep -q .; then
  warn "no CMYK press profile (e.g. FOGRA39/ISO Coated v2) — get it from your printer, put it in ~/.local/share/icc"
fi

section "Companion apps"
pkg inkscape
pkg gimp

summary
