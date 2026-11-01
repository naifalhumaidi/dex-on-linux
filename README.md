# scrcpy + DeX on Linux

Use your Galaxy as a Linux desktop. Replaces the retired **DeX for PC** app.
Should work
on any distro with scrcpy 3+.

## TL;DR

```bash
./scripts/install.sh          # installs scrcpy + adb, makes 3 launchers
```

Phone: Build number ×7 → Developer options → USB debugging ON → plug in USB →
*File transfer* → accept **Allow USB debugging**.
Check with `adb devices`.

You get 3 app-menu launchers: **Mirror Phone** (gaming, 120Hz) · **Dex FHD** ·
**Dex 2K** (real desktop, 60Hz).

## Requirements

- scrcpy **3+** (needs `--new-display`), `adb`, a USB data cable
- Phone with Android 16 / One UI 8 DeX

## Install by distro

**Arch / CachyOS:** `sudo pacman -S scrcpy android-tools`
**Fedora:** `sudo dnf install scrcpy android-tools`
**Debian/Ubuntu:** `sudo apt install scrcpy adb`
  *(if your distro's scrcpy is older than 3, grab the official release from
  scrcpy.github.io instead)*

The script below picks the right one automatically.

## Mirror vs DeX

- **Mirror** = real screen, touch, 120Hz, no windows
- **DeX** = virtual screen, windows + taskbar, always 60Hz (Android limit)

## Most important options

| Flag | Does |
|---|---|
| `--new-display=WxH/DPI` | Virtual screen. `/DPI` = icon size (free). Not fps |
| `--gamepad=uhid` | Controller (off by default, required) |
| `-M` | True mouse. Traps cursor (`Alt+M` free) |
| `-m1920` | Smaller video stream. Omit for full quality |
| `-b16M` | More bitrate if text is blocky |

Bigger DeX icons (phone-side, not a flag): `./scripts/dex-zoom.sh 280` then
restart scrcpy.

## Fixes

| Problem | Fix |
|---|---|
| Phone not in adb | USB debugging off, charge-only cable/port, or phone in USB-tethering — set File transfer / MTP |
| Input ignored | Developer options → **USB debugging (Security settings)** → reboot |
| Games look worse in DeX | Game renders less for the 60Hz screen — try Game Booster Plus |
| Controller stick dead | Rebind in the game's own controls |
| Back-swipe gone | Settings → Display → Navigation bar → toggle Back gesture |
| Recents empty / taskbar icons tiny | Known One UI 8 virtual-display bugs — no fix. Use the app drawer |

## Won't work

Wine/Proton/VM · HDMI → laptop (no HDMI-in) · Waydroid · `--gamepad=aoa`.

Floating macro buttons: **Key Mapper** (`io.github.sds100.keymapper`, FOSS).

**See `CHEATSHEET.md` for every command, `NOTES.md` for dead ends.**
