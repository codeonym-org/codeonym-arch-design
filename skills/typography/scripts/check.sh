#!/usr/bin/env bash
# Check font tools and the key font families.
. "$(dirname "$(readlink -f "$0")")/../../../lib/check.sh"

section "Font tools"
pkg font-manager
pkg gnome-font-viewer
pkg fontforge
bin fc-list

section "Font packages"
for p in inter-font ttf-ibm-plex adobe-source-sans-fonts adobe-source-serif-fonts adobe-source-code-pro-fonts \
         ttf-roboto ttf-opensans ttf-fira-code ttf-jetbrains-mono noto-fonts noto-fonts-cjk noto-fonts-emoji \
         noto-fonts-extra ttf-liberation ttf-dejavu; do
  pkg "$p"
done

section "Library"
info "$(fc-list : family | sort -u | wc -l) families, $(fc-list | wc -l) font files"
user_fonts=$(find "$HOME/.local/share/fonts" -type f 2>/dev/null | wc -l)
info "$user_fonts user-installed font file(s) in ~/.local/share/fonts"

summary
