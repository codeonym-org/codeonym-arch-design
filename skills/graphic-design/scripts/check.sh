#!/usr/bin/env bash
# Check the graphic-design toolkit.
. "$(dirname "$(readlink -f "$0")")/../../../lib/check.sh"

section "Editors"
pkg gimp
pkg inkscape
bin gimp-console-3.2 "GIMP batch (gimp-console-3.2)"

section "GIMP plugins"
pkg gimp-plugin-gmic
pkg gimp-plugin-resynthesizer aur
pkg gimp-help-en

section "Image processing"
pkg imagemagick
pkg potrace
pkg libwebp
pkg libavif
pkg libjxl

section "Optimizers"
pkg pngquant
pkg oxipng
pkg optipng
pkg jpegoptim
pkg curtail

section "Helpers"
pkg eyedropper
pkg upscayl-bin aur

summary
