#!/usr/bin/env bash
# Check the UI design toolkit.
. "$(dirname "$(readlink -f "$0")")/../../../lib/check.sh"

section "Design apps"
pkg lunacy-bin aur
pkg inkscape
pkg eyedropper

section "Browser design tools"
for url in https://design.penpot.app https://www.figma.com; do
  if curl -fsS -o /dev/null -m 8 "$url"; then info "reachable: $url"; else warn "not reachable: $url"; fi
done

section "UI fonts"
for fam in "Inter" "IBM Plex Sans" "Roboto" "Source Sans 3" "JetBrains Mono"; do
  if fc-list ":family=$fam" family | grep -q .; then info "font: $fam"; else warn "font missing: $fam"; fi
done

section "Icon/asset tools"
pkg imagemagick
pkg oxipng

summary
