#!/usr/bin/env bash
. "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")/env.sh"
# Shared helpers for the codeonym-arch-design check scripts.
# Source it:  . "$(dirname "$(readlink -f "$0")")/../../../lib/check.sh"

if [[ -t 1 ]]; then
  C_OK=$'\e[32m'; C_BAD=$'\e[31m'; C_WARN=$'\e[33m'; C_DIM=$'\e[2m'; C_B=$'\e[1m'; C_0=$'\e[0m'
else
  C_OK=; C_BAD=; C_WARN=; C_DIM=; C_B=; C_0=
fi

CHECK_MISSING_PACMAN=()
CHECK_MISSING_AUR=()
CHECK_FAILS=0

section() { printf '\n%s== %s ==%s\n' "$C_B" "$1" "$C_0"; }

# pkg <package> [aur] [note]  -> reports installed version or missing
pkg() {
  local name=$1 src=${2:-repo} note=${3:-} v
  if v=$(pacman -Q "$name" 2>/dev/null); then
    printf '  %s✔%s %-34s %s%s%s\n' "$C_OK" "$C_0" "${v% *}" "$C_DIM" "${v#* }" "$C_0"
  else
    printf '  %s✘%s %-34s %smissing (%s)%s %s\n' "$C_BAD" "$C_0" "$name" "$C_WARN" "$src" "$C_0" "$note"
    CHECK_FAILS=$((CHECK_FAILS + 1))
    if [[ $src == aur ]]; then CHECK_MISSING_AUR+=("$name"); else CHECK_MISSING_PACMAN+=("$name"); fi
  fi
}

# bin <command> [label]  -> reports which binary resolves on PATH
bin() {
  local b=$1 label=${2:-$1} p
  if p=$(command -v "$b"); then
    printf '  %s✔%s %-34s %s%s%s\n' "$C_OK" "$C_0" "$label" "$C_DIM" "$p" "$C_0"
  else
    printf '  %s✘%s %-34s %snot on PATH%s\n' "$C_BAD" "$C_0" "$label" "$C_WARN" "$C_0"
    CHECK_FAILS=$((CHECK_FAILS + 1))
  fi
}

info() { printf '  %s•%s %s\n' "$C_DIM" "$C_0" "$*"; }
warn() { printf '  %s!%s %s\n' "$C_WARN" "$C_0" "$*"; }

summary() {
  echo
  if ((CHECK_FAILS == 0)); then
    printf '%sAll checks passed.%s\n' "$C_OK" "$C_0"
    return 0
  fi
  printf '%s%d item(s) missing.%s Install with:\n' "$C_WARN" "$CHECK_FAILS" "$C_0"
  ((${#CHECK_MISSING_PACMAN[@]})) && echo "  sudo pacman -S --needed ${CHECK_MISSING_PACMAN[*]}"
  ((${#CHECK_MISSING_AUR[@]})) && echo "  yay -S --needed ${CHECK_MISSING_AUR[*]}"
  return 1
}
