#!/usr/bin/env bash
# Install scrcpy + adb, icons, and 3 launchers. Idempotent. DRY=1 to preview.
# Tested on CachyOS. Should work on any modern distro with scrcpy 3+.
set -euo pipefail
DRY="${DRY:-0}"
say() { printf '\n\033[1;36m==> %s\033[0m\n' "$*"; }
exec_if() { [ "$DRY" = "1" ] && echo "  DRY: $*" || "$@"; }

say "Packages"
if command -v scrcpy >/dev/null && command -v adb >/dev/null; then
  echo "  scrcpy and adb already present — skipping"
else
  if command -v pacman >/dev/null; then P=(sudo pacman -S --needed scrcpy android-tools)
  elif command -v dnf    >/dev/null; then P=(sudo dnf install -y scrcpy android-tools)
  elif command -v apt    >/dev/null; then P=(sudo apt install -y scrcpy adb)
  else
    echo "  No known package manager. Install scrcpy 3+ and adb manually:"
    echo "    scrcpy: https://github.com/Genymobile/scrcpy/releases"
    exit 1
  fi
  echo "  Running: ${P[*]}"
  exec_if "${P[@]}"
fi

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

say "Icons"
mkdir -p ~/.local/share/icons
exec_if cp "$HERE"/../icons/*.svg ~/.local/share/icons/ || true

say "Launchers"
for f in "$HERE"/../launchers/*.desktop.in; do
  [ -e "$f" ] || continue
  name="$(basename "$f" .desktop.in)"
  if [ "$DRY" = "1" ]; then echo "  DRY: write $name.desktop"; continue; fi
  sed "s|@ICON_DIR@|$HOME/.local/share/icons|g" "$f" > ~/.local/share/applications/"$name.desktop"
  chmod +x ~/.local/share/applications/"$name.desktop"
  echo "  installed $name"
done

[ "$DRY" = "1" ] && { say "Dry run done, nothing changed"; exit 0; }
update-desktop-database ~/.local/share/applications 2>/dev/null || true
command -v kbuildsycoca6 >/dev/null && kbuildsycoca6 --noincremental 2>/dev/null || true

say "Done. Look for: Mirror Phone, Dex FHD, Dex 2K"
cat <<EOF

On the phone, once:
  Build number x7 -> Developer options -> USB debugging ON
  Plug in USB -> choose File transfer / MTP -> Accept the prompt

From the PC:
  adb devices
EOF
