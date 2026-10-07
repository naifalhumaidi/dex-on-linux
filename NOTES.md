# Notes — dead ends, don't retry

## Works
- `scrcpy --new-display=WxH/DPI` — the whole trick. DeX renders onto a virtual screen
- `scrcpy` plain — mirrors real screen, no DeX
- Virtual screen is always 60Hz (Android limit, verified with dumpsys)
- `--gamepad=uhid` — required, controllers off by default
- `screen_zoom_on_external_desktop_display=280` — only thing that resizes DeX labels/taskbar

## Broken, don't retry
| Thing | Why |
|---|---|
| `--gamepad=aoa` | libusb error — adb holds the USB port |
| `/320` DPI for icons | Applies, Samsung ignores it. Use screen_zoom |
| Wine/Proton/VM | DeX-for-Windows was just a thin viewer |
| DeX for PC app | Dropped for One UI 7+ / S25 & Fold series |
| DeX for Mac | Killed Jan 2022 |
| Fold resolution picker | S-series only, not on Folds |
| "Freeform windows on secondary display" | Wrong build name |
| HDMI → laptop | No HDMI input |
| LocalDex | Mirrors phone screen with black bars, needs Wi-Fi pairing every launch, id changes each time |
| Persistent overlay display | `overlay_display` service missing on this device |
| Recents shows no apps | Known One UI 8 virtual-display bug — no fix |
| Taskbar icons tiny | Samsung removed the setting |

## I was wrong about
- `--otg` + `--fullscreen` can't combine
- "~160 DPI cap on Folds" — fabricated; `/320` works, Samsung just ignores it
- `-m` being a real Fold 6 perf win — marginal
- `-b16M` as a general fix — optional, wrong source cited
- Only `Alt+F4` frees the mouse — `Alt+M` does
- "Default mouse useless for games" — too strong; `-M` is for picky games

## Hardware (tested on)
- Galaxy Z Fold 6 (SM-F956U), Android 16, One UI 8
- Panel 2560x1600 @120Hz, KDE scale 2
- Distro: **CachyOS**. Other distros need scrcpy 3+ and the right package name (see README)

## Untested
- screen_zoom above 280
- Controller under `--new-display`
- Waydroid (no image, ~2GB)
