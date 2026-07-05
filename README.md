# Helium++

Helium++ is a `version.dll` injection project for Helium on Windows. It is loaded alongside `helium.exe` and augments browser behavior at startup with tab, hotkey, portable, command-line, and policy-related features.

This project is adapted from Chrome++ Next for the Chromium-based [Helium](https://github.com/imputnet/helium) browser.

## Overview

- Targets Helium on Windows.
- Works by placing `version.dll` next to `helium.exe`.
- Focuses on practical browser behavior changes instead of UI wrappers or extensions.
- Prioritizes capabilities that browser extensions cannot implement well.

## Installation

- Put `version.dll` in the same directory as `helium.exe`.
- Put `helium++.ini` in the same directory to customize behavior.
- The project is intended for portable Helium deployments.
- If `version.dll` is not loaded correctly, you can try [setdll](https://github.com/Bush2021/setdll/).

## Capability Overview

### Tab and bookmark behavior

- Double-click to close tabs.
- Right-click to close tabs, with `Shift` preserving the original menu.
- Keep the last tab from closing the browser window.
- Switch tabs with the mouse wheel over the tab strip.
- Switch tabs with the mouse wheel while holding the right mouse button.
- Open omnibox input or bookmarks in a new tab.
- Control new-tab detection through `new_tab_disable` and `new_tab_disable_name`.

### Hotkeys and input remapping

- Configure a boss key to hide and restore Helium windows, and mute or restore audio.
- Configure a translate hotkey.
- Remap hotkeys to other key combinations or Chromium command IDs through `keymapping`.

### Portable deployment and startup behavior

- Override `data_dir` and `cache_dir` for portable use.
- Append Chromium switches through `command_line`.
- Run commands or programs with `launch_on_startup` and `launch_on_exit`.

### Browser environment controls

- Ignore enterprise policies with `ignore_policies`.
- Enable the `win32k` fallback only when Helium++ itself causes startup crashes.
- Suppress false "out of date" upgrade notifications on portable installs with `suppress_false_upgrade_notification`.
- Additional public options such as `show_password` are documented in [`src/helium++.ini`](src/helium++.ini).

## Configuration Reference

See [`src/helium++.ini`](src/helium++.ini) for the full public configuration surface.

## Build

```powershell
xmake f -m release
xmake
```

The release build emits `version.dll`.

## License

This repository keeps the original GPL-3.0 license. Versions 1.5.4 and earlier of the upstream Chrome++ project were licensed under MIT by [Shuax](https://github.com/shuax/); versions 1.6.0 and later are GPL-3.0.
