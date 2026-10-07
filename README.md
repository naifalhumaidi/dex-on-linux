# scrcpy + DeX on Linux

Use your Galaxy as a Linux desktop. Replaces the retired **DeX for PC** app.

Tested on CachyOS/KDE with Galaxy Z Fold 6 (Android 16).

## Install

```bash
./scripts/install.sh
```

Installs scrcpy + android-tools, copies icons, creates 3 launchers.

On the phone, once: Build number ×7 → Developer options → **USB debugging ON**
→ plug in USB → *File transfer* → accept **Allow USB debugging**.

Check: `adb devices` shows your phone.

## Launchers

| Name | Use for |
|---|---|
| **Mirror Phone** | Gaming — real screen, 120Hz |
| **Dex FHD** | Light desktop, smoother |
| **Dex 2K** | Crispest |

## Mirror vs DeX

- **Mirror** = real screen, touch, 120Hz, no windows
- **DeX** = virtual screen, windows + taskbar, always 60Hz

60Hz is an Android limit. Competitive FPS → use Mirror Phone.

## Flags

| Flag | Meaning |
|---|---|
| `--new-display=1920x1200/224` | Virtual screen. `/224` = icon size, free. Not refresh rate |
| `--gamepad=uhid` | Required — controllers aren't sent by default |
| `-M` | Real mouse. Traps your cursor (`Alt+M` frees) |
| `-m1920` | Smaller video stream. Omit for full quality |
| `-b16M` | More bitrate if text is blocky |

## Bigger DeX UI

Icon size needs a phone-side setting, not a flag:

```bash
./scripts/dex-zoom.sh 280     # restart scrcpy after
```

## Fixes

| Problem | Fix |
|---|---|
| Games look worse in DeX | Game renders less for a 60Hz screen. Try `Game Booster Plus` |
| Controller stick dead | Rebind in the game's own controls |
| Back-swipe gone | `Settings → Display → Navigation bar` → toggle Back gesture |
| Phone not in adb | USB debugging off, or cable is charge-only |
| Input ignored | Developer options → **USB debugging (Security settings)** → reboot |
| Recents shows no apps | Known One UI 8 virtual-display bug — no fix. Use the app drawer |
| Taskbar icons stay tiny | Samsung deleted the setting — no fix. `/DPI` sizes labels only. Use the app drawer |
| | |

Also note adb shows nothing if the **port* paid is charge-only or the phone rebooted into USB tethering — switch to File transfer / MTP in the USB notification.

## Won't work

- Wine/Proton/VM — worse, wastes RAM
- HDMI → laptop — no HDMI in port
- Waydroid — separate Android, not your phone
- `--gamepad=aoa` — broken, adb holds USB

## Key Mapper

Floating macro buttons bound to keys (`io.github.sds100.keymapper`, FOSS).
No joystick support.

## More

- `CHEATSHEET.md` — all commands
- `NOTES.md` — dead ends, don't retry
