#!/usr/bin/env bash
# Adjust the Samsung DeX UI scale (the real knob for icon/taskbar size).
# usage: dex-zoom.sh [160|192|220|256|280]
set -euo pipefail

VAL="${1:-280}"
KEY=screen_zoom_on_external_desktop_display

if ! adb get-state >/dev/null 2>&1; then
  echo "No adb device. Plug in the phone and accept USB debugging." >&2
  exit 1
fi

old=$(adb shell settings get global "$KEY" | tr -d '\r')
adb shell settings put global "$KEY" "$VAL"
new=$(adb shell settings get global "$KEY" | tr -d '\r')

echo "screen_zoom_on_external_desktop_display: $old -> $new"
echo "Restart scrcpy for it to take effect."
echo
echo "  160  tiny (Samsung default)"
echo "  192  small"
echo "  280  good (what we use)"
echo "  256  large"
