# Cheatsheet

## Setup
```bash
./scripts/install.sh
adb devices
```
Phone: Build number ×7 → Developer options → USB debugging ON → File transfer.

## Launchers
| Name | Command |
|---|---|
| Mirror Phone | `scrcpy --gamepad=uhid` |
| Dex FHD | `scrcpy --new-display=1920x1200/224 --fullscreen --gamepad=uhid` |
| Dex 2K | `scrcpy --new-display=2560x1600/224 --fullscreen --gamepad=uhid` |

## Sizes
```bash
scrcpy --new-display=1368x912/224  --fullscreen --gamepad=uhid   # biggest UI
scrcpy --new-display=1920x1200/224 --fullscreen --gamepad=uhid   # balanced
scrcpy --new-display=2560x1600/224 --fullscreen --gamepad=uhid   # crisp
```

## DeX icon size
```bash
./scripts/dex-zoom.sh 280     # restart scrcpy after
```

## Input
```bash
scrcpy --gamepad=uhid   # controller (required)
scrcpy -M               # true mouse, traps cursor (Alt+M frees)
```

## Apps
```bash
adb install -r app.apk
for f in *.apk; do adb install -r "$f"; done
```

## Keys
`Alt+F` fullscreen · `Alt+M` mute/release mouse · `Alt+Q` quit · `Alt+S` home
`Alt+b` back · `Alt+p` power · `Alt+i` fps · `Ctrl+Shift+V` paste to phone

## Check
```bash
adb shell wm size
scrcpy --list-displays
scrcpy --list-apps
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
adb shell settings put global screen_zoom_on_external_desktop_display 160
```
