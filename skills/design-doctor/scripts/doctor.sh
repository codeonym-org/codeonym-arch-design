#!/usr/bin/env bash
# Run every codeonym-arch-design check and print one summary.
# Usage: doctor.sh [--verbose]
. "$(dirname "$(readlink -f "$0")")/../../../lib/env.sh"
skills_dir="$(dirname "$(readlink -f "$0")")/../.."
verbose=0; [[ ${1:-} == --verbose ]] && verbose=1
if [[ -t 1 ]]; then G=$'\e[32m' R=$'\e[31m' Y=$'\e[33m' B=$'\e[1m' N=$'\e[0m'; else G= R= Y= B= N=; fi

printf '%scodeonym design workstation — health check%s\n' "$B" "$N"
printf 'host %s · %s %s · %s\n\n' "$(uname -n)" "${XDG_CURRENT_DESKTOP:-?}" "${XDG_SESSION_TYPE:-?}" \
  "$(lspci 2>/dev/null | grep -Ei 'vga|3d' | sed -E 's/.*\[(Radeon[^]]*)\].*/\1/' | head -1)"

pac=(); aur=()
printf '%-18s %-8s %s\n' "SKILL" "STATUS" "MISSING"
for check in "$skills_dir"/*/scripts/check.sh; do
  skill=$(basename "$(dirname "$(dirname "$check")")")
  [[ $skill == design-doctor ]] && continue
  out=$(bash "$check" 2>&1); rc=$?
  missing=$(grep -E '✘' <<<"$out" | awk '{print $2}' | tr '\n' ' ')
  if ((rc == 0)); then printf '%-18s %s%-8s%s\n' "$skill" "$G" "ok" "$N"
  else printf '%-18s %s%-8s%s %s\n' "$skill" "$R" "missing" "$N" "$missing"; fi
  while read -r line; do
    [[ $line == *"sudo pacman -S --needed"* ]] && pac+=(${line#*--needed })
    [[ $line == *"yay -S --needed"* ]] && aur+=(${line#*--needed })
  done <<<"$out"
  ((verbose)) && { echo "$out" | sed 's/^/    /'; echo; }
done

echo
printf '%sPATH shadowing%s\n' "$B" "$N"
found=0
for t in ffmpeg ffprobe perl python3 cwebp magick gs; do
  if p=$(shadowed "$t"); then
    found=1
    case $t in
      ffmpeg|ffprobe) why="no VAAPI hardware encoding" ;;
      perl) why="breaks exiftool" ;;
      python3) why="breaks Blender's numpy/glTF when launched from a terminal" ;;
      *) why="differs from the Arch build" ;;
    esac
    printf '  %s!%s %-8s → %s (%s)\n' "$Y" "$N" "$t" "$p" "$why"
  fi
done
if ((found)); then
  echo "  Skill scripts already work around this. To fix it for your whole shell, add this line"
  echo "  to ~/.zshrc right AFTER the 'brew shellenv' line (moves Homebrew to the end of PATH):"
  echo '    path=(${path:#/home/linuxbrew/.linuxbrew/*} /home/linuxbrew/.linuxbrew/bin /home/linuxbrew/.linuxbrew/sbin)'
else
  echo "  none"
fi

echo
printf '%sStorage%s\n' "$B" "$N"
read -r avail pcent < <(df -h --output=avail,pcent "$HOME" | tail -1)
printf '  home: %s free (%s used)\n' "$avail" "$pcent"
((${pcent%\%} >= 90)) && printf '  %s!%s disk nearly full — 1 h of 1080p60 OBS recording ≈ 4–8 GB; Blender/Kdenlive caches grow too\n' "$Y" "$N"
for d in ~/Videos/OBS ~/.cache/darktable ~/.cache/kdenlive ~/.cache/blender; do
  [[ -d $d ]] && printf '  %-28s %s\n' "${d/#$HOME/\~}" "$(du -sh "$d" 2>/dev/null | cut -f1)"
done

if ((${#pac[@]} + ${#aur[@]})); then
  echo; printf '%sInstall everything missing:%s\n' "$B" "$N"
  ((${#pac[@]})) && echo "  sudo pacman -S --needed $(printf '%s\n' "${pac[@]}" | sort -u | tr '\n' ' ')"
  ((${#aur[@]})) && echo "  yay -S --needed $(printf '%s\n' "${aur[@]}" | sort -u | tr '\n' ' ')"
  exit 1
fi
