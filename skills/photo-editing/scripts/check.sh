#!/usr/bin/env bash
# Check the photo-editing toolkit.
. "$(dirname "$(readlink -f "$0")")/../../../lib/check.sh"

section "Development & retouching"
pkg darktable
bin darktable-cli
pkg gimp
pkg gimp-plugin-resynthesizer aur
pkg gimp-plugin-gmic

section "Utilities"
pkg upscayl-bin aur
pkg perl-image-exiftool
pkg imagemagick
if /usr/bin/perl /usr/bin/vendor_perl/exiftool -ver &>/dev/null; then info "exiftool runs with system perl"; else warn "exiftool broken"; fi
if ! exiftool -ver &>/dev/null; then warn "plain \`exiftool\` fails: a Homebrew perl shadows /usr/bin/perl — scripts call /usr/bin/perl explicitly"; fi

section "darktable styles"
styles_dir="$HOME/.config/darktable/styles"
if compgen -G "$styles_dir/*.dtstyle" >/dev/null; then
  for s in "$styles_dir"/*.dtstyle; do info "style: $(basename "$s" .dtstyle)"; done
else
  info "no saved styles yet (darktable → lighttable → styles → create)"
fi

summary
