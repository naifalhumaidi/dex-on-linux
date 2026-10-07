# Notes

## Works
- `scrcpy --new-display=WxH/DPI` — the whole trick. DeX renders onto the virtual screen
- `scrcpy` plain — mirrors real screen, no DeX
- Virtual screen is **always 60Hz** (Android limit, checked with dumpsys)
- `--gamepad=uhid` — required
- `screen_zoom_on_external_desktop_display` — only thing that resizes DeX icons

## Cable / connection troubleshooting (cost me hours)
- **`adb devices` empty but `lsusb` shows the phone** → check the *port*, not the cable. A charge-only port/adaptor exposes **no adb interface at all**, so toggling USB debugging does nothing
- Confirmed working: node perms are fine (`test -w /dev/bus/usb/...` → OK), and `pacman -Qkk android-tools` → `0 altered files`
- **Arch's `android-tools` ships no udev rules at all** — the file list contains only `/usr/bin/*`, man pages, completions. adb relies on `50-udev-default.rules` granting access, which is fragile across re-enumeration
- A `51-android.rules` with `MODE="0666"` did **not** help (permissions were never the problem). Harmless to leave in place
- Samsung only exposes adb when USB mode is **File transfer / MTP** — "USB tethering" (CDC Data) and "Charging only" do not
- After a reboot the phone can come up on the wrong USB mode; fix on-device via the notification shade

## Final settings on the phone
| Setting | Value | Note |
|---|---|---|
| `screen_zoom_on_external_desktop_display` | **280** | Real improvement — app labels readable |
| `force_desktop_mode_on_external_displays` | 0 (reverted) | Did nothing |
| Installed | Key Mapper (`io.github.sds100.keymapper`) | Floating macro buttons |
| Problem | Verdict |
|---|---|
| **Recents / app switcher shows no apps** | Known trait of One UI 8 virtual-display desktop mode. `force_desktop_mode_on_external_displays=1` did **not** help. Confirmed by r/scrcpy: *"the major differences in Desktop Mode vs DeX are the Recent Apps not working"* |
| **Taskbar pinned icons stay tiny** | `/DPI` raises labels but not taskbar icons. Samsung **removed** the setting — Android Authority: *"You can't right click the taskbar to access taskbar settings"* |
| **`Settings → Connected devices → Samsung DeX`** | Activity does not exist on this build — that's why no display/DPI options are findable |
| No `Settings > DeX` page | Verified absent in `dumpsys package com.android.settings` |

**Workaround for both:** use the app drawer (which looks correct at `screen_zoom=280`) instead of the taskbar, and switch apps from there.
| Thing | Why |
|---|---|
| **LocalDex** (`com.localdex`) | 27 MB debug APK, needs Wi-Fi Wireless-ADB pairing on *every* launch, and the display id changes each time (9→11→13→16→26). Worse, it just mirrors the phone screen with black bars — no gain over `--new-display`. Its "resizable windows" trick needs One UI 8.5+ anyway |
| Persistent overlay display | `cmd overlay_display` service **does not exist** on SM-F956U (`Can't find service`), so `overlay_display_devices` can't be used. No way to pin a virtual display without an app |
| **`overlay_display_devices`** | Setting is `null` and the service is missing. Dead on this device |
| Thing | Why |
|---|---|
| `--gamepad=aoa` | libusb error, adb holds USB |
| `/320` DPI for icons | Applies, Samsung ignores it. Use screen_zoom |
| Wine/Proton/VM | DeX-for-Windows was just a viewer |
| DeX for PC on Fold 6 | Dropped in One UI 7 |
| DeX for Mac | Killed 2022 |
| Fold res picker | S-series only |
| "Freeform windows on secondary display" | Wrong build name. Not needed |
| HDMI → laptop | No HDMI in |

## I was wrong about
- `--otg` + `--fullscreen` — can't combine
- A ~160 DPI cap on Folds — made that up, `/320` works
- `-m` being a real perf win on Fold 6 — barely matters
- `-b16M` as a general fix — optional, and I cited the wrong source
- Only `Alt+F4` frees the mouse — `Alt+M` does
- "Default mouse is useless for games" — too strong, `-M` is for picky games

## Untested
- screen_zoom above 280
- controller under --new-display
- Waydroid (no image, ~2GB)

## Hardware
- 2560x1600 @120Hz · Z Fold 6 (SM-F956U) · Android 16
- Cover 968x2376 · Inner 1856x2160
