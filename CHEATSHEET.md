# Cheatsheet

## Setup
```bash
./scripts/install.sh
adb devices
```
Phone: Build number ×7 → Developer options → USB debugging ON.

## Launchers
| Name | Command |
|---|---|
| Mirror Phone | `scrcpy --gamepad=uhid` |
| Dex FHD | `scrcpy --new-display=1920x1200/224 --fullscreen --gamepad=uhid` |
| Dex 2K | `scrcpy --new-display=2560x1600/224 --fullscreen --gamepad=uhid` |

## Screen sizes
```bash
scrcpy --new-display=1368x912/224   --fullscreen --gamepad=uhid  # big UI
scrcpy --new-display=1920x1200/224  --fullscreen --gamepad=uhid  # balanced
scrcpy --new-display=2560x1600/224  --fullscreen --gamepad=uhid  # crisp
scrcpy --new-display=2560x1600/224 -m1920 --fullscreen --gamepad=uhid # light
```

## DeX icon size
```bash
./scripts/dex-zoom.sh 280     # restart scrcpy after
```

## Input
```bash
scrcpy --gamepad=uhid     # controller
scrcpy -M                 # real mouse, traps cursor (Alt+M frees)
# not --gamepad=aoa
```

## Apps
```bash
adb install -r app.apk
adb uninstall <package>
for f in *.apk; do adb install -r "$f"; done
```

## Keys
`Alt+F` fullscreen · `Alt+M` mute/release mouse · `Alt+Q` quit · `Alt+S` home
`Alt+b` back · `Alt+p` power · `Alt+i` fps · `Ctrl+Shift+V` paste to phone

## Check
```bash
adb shell wm size        # native res
scrcpy --list-displays
scrcpy --list-apps
scrcpy --print-fps
adb shell am start -n <pkg>/<activity> --display <id>
```

## Wireless
```bash
adb tcpip 5555 && adb connect <phone-ip>:5555
scrcpy --tcpip --new-display=1920x1200/224 --fullscreen --gamepad=uhid
```

## Remove
```bash
rm ~/.local/share/applications/{dex-fhd,dex-2k,mirror-phone}.desktop \
   ~/.local/share/icons/{dex-monitor,phone-mirror}.svg
adb shell settings put global screen_zoom_on_external_desktop_display 160   # reset
```
