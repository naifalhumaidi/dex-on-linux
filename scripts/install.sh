#!/usr/bin/env bash
# Install everything needed for scrcpy + Samsung DeX on Arch/CachyOS.
# Idempotent: safe to re-run. Never touches anything outside pacman + ~/.local.
set -euo pipefail

DRY="${DRY:-0}"

say()  { printf '\n\033[1;36m==> %s\033[0m\n' "$*"; }
run()  { if [ "$DRY" = "1" ]; then echo "  DRY: $*"; else "$@"; fi; }

# ---------------------------------------------------------------- packages
say "Checking packages"
PKGS=(scrcpy android-tools)
MISSING=()
for p in "${PKGS[@]}"; do
  if pacman -Qq 2>/dev/null | grep -qx "$p"; then
    echo "  ok      $p"
  else
    echo "  MISSING $p"
    MISSING+=("$p")
  fi
done

if [ ${#MISSING[@]} -gt 0 ]; then
  say "Installing: ${MISSING[*]}"
  echo "  Needs sudo. Size is small (~10-20 MB total, no build step)."
  if [ "$DRY" = "1" ]; then
    echo "  DRY: sudo pacman -S --needed ${MISSING[*]}"
  else
    sudo pacman -S --needed "${MISSING[@]}"
  fi
else
  say "All packages present, skipping pacman"
fi

# ---------------------------------------------------------------- icons
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ICON_SRC="$HERE/../icons"

say "Installing icons"
if [ -d "$ICON_SRC" ]; then
  if [ "$DRY" = "1" ]; then
    echo "  DRY: would copy $(basename -a "$ICON_SRC"/*.svg) -> ~/.local/share/icons/"
  else
    mkdir -p ~/.local/share/icons
    cp -v "$ICON_SRC"/*.svg ~/.local/share/icons/ 2>/dev/null || true
  fi
else
  echo "  icons/ not found next to this script, skipping"
fi

# ---------------------------------------------------------------- launchers
say "Installing launchers"
for f in "$HERE"/../launchers/*.desktop.in; do
  [ -e "$f" ] || { echo "  launchers/ not found, skipping"; break; }
  name="$(basename "$f" .desktop.in)"
  target=~/.local/share/applications/"$name.desktop"
  if [ "$DRY" = "1" ]; then
    echo "  DRY: would write $target"
    continue
  fi
  sed "s|@ICON_DIR@|$HOME/.local/share/icons|g" "$f" > "$target"
  chmod +x "$target"
  echo "  installed $name"
done

if [ "$DRY" = "1" ]; then
  say "Dry run complete, nothing was changed."
  exit 0
fi

update-desktop-database ~/.local/share/applications 2>/dev/null || true
command -v kbuildsycoca6 >/dev/null && kbuildsycoca6 --noincremental 2>/dev/null || true
command -v gtk-update-icon-cache >/dev/null && gtk-update-icon-cache -f -t ~/.local/share/icons 2>/dev/null || true

say "Done. Look for 'Mirror Phone', 'Dex FHD', 'Dex 2K' in your app menu."
cat <<EOF

Next steps (on the PHONE, one time):
  1. Settings -> About phone -> Software information
  2. Tap "Build number" 7 times
  3. Settings -> Developer options -> enable "USB debugging"
  4. Plug in USB cable, choose "File transfer / MTP"
  5. Accept "Allow USB debugging?" on the phone (tick Always allow)

Verify from the PC:
  adb devices        # should list your phone as "device"

EOF
