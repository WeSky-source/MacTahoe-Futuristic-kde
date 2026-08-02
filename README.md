# MacTahoe-Futuristic

A community palette fork of [vinceliuice/MacTahoe-kde](https://github.com/vinceliuice/MacTahoe-kde) (GPLv3) — all credit for the original design, layout, and engineering goes to Vince Liuice and the MacTahoe-kde contributors. This fork only changes the color palette, adds a matching cursor set, and tunes compositor defaults; it is not original art.

## What's different from upstream

- **Palette**: warm charcoal near-black background (`rgb(25,18,13)` / alt `rgb(35,27,22)`), teal accent (`rgb(0,209,218)`), amber/orange accent (`rgb(240,166,70)`), off-white foreground (`rgb(245,241,236)`) — applied across the color scheme, Aurorae window decoration, Plasma desktop theme, and look-and-feel package.
- **Icons**: a `MacTahoe-Futuristic` icon theme forked from `MacTahoe-dark`. Folder icons, the generic-app fallback icon, places/devices icons, and any icon that used the base theme's Breeze-blue accent (`#3daee9`, `#5294e2`, and related blue-family gradient stops) were recolored into the teal/amber pair — teal for primary accent, amber for secondary/highlight elements like the folder tab. Gradients were kept as gradients (not flattened) for a retro-futuristic glow rather than flat fills. Third-party app logos were intentionally left untouched — only the theme's own generic/fallback icons and UI-accent colors were repainted, since that's what actually shows up everywhere in the interface.
- **Cursors**: a `MacTahoe-Futuristic-cursors` theme forked from `MacTahoe-dark-cursors`. The scalable SVG cursor sources that exist in the upstream package (the animated `wait`/`progress` spinners and `openhand`) were recolored into an alternating teal/amber pattern. **Caveat**: the upstream `MacTahoe-dark-cursors` package ships most single-frame cursors (pointer, default arrow, text, resize handles, etc.) only as pre-compiled Xcursor binaries, with no SVG source present in `cursors_scalable/` for them — only `wait`, `progress`, and `openhand` have real source files. Regenerating the compiled bitmaps would require `xcursorgen` (not installed, and installing it needs root, which this project intentionally never does). So the compiled `cursors/` directory is carried over unmodified — most cursors will still render with the original blue accent until someone rebuilds the bitmaps from recolored SVGs.
- **SDDM login theme**: a `MacTahoe-Futuristic` SDDM theme staged under `sddm/MacTahoe-Futuristic/`, forked from `MacTahoe-Dark`. The accent color (`theme.conf`) and the button/login SVG assets were repainted from `#1d99f3`/`#3daee9` to the teal accent.
- **Compositor tuning**: this fork favors a resource-light look over heavy glass/blur. See "Performance notes" below for the exact settings — kept out of the packaged files since they're user compositor config, not theme assets.

## Install

```bash
git clone <this-repo-url>
cd MacTahoe-Futuristic-kde
./install.sh
```

`install.sh` copies each piece into the correct XDG user location:

| Component | Destination |
|---|---|
| Aurorae window decoration | `~/.local/share/aurorae/themes/` |
| Plasma desktop theme | `~/.local/share/plasma/desktoptheme/` |
| Look-and-feel package | `~/.local/share/plasma/look-and-feel/` |
| Color scheme | `~/.local/share/color-schemes/` |
| Icon theme | `~/.local/share/icons/` |
| Cursor theme | `~/.icons/` |

It does **not** touch `/usr` or run `sudo`. The SDDM login theme needs root, so the script prints a manual copy command instead of running it for you:

```bash
sudo cp -r sddm/MacTahoe-Futuristic /usr/share/sddm/themes/
```

Then set it as the active theme in `/etc/sddm.conf.d/*.conf` under `[Theme] Current=MacTahoe-Futuristic`, or via the SDDM KCM in System Settings if installed.

After installing, apply the theme via **System Settings > Appearance > Global Theme** (pick "MacTahoe-Futuristic"), or set each piece individually in the relevant Appearance sub-pages.

## Performance notes

The upstream look-and-feel package doesn't force blur or transparency — those come from general KWin/Plasma user settings. If you want the same resource-light setup this fork was tuned with:

- `~/.config/kwinrc`: `[Effect-blur] BlurStrength=3` (low, not the KWin default max), `[Plugins] contrastEnabled=false` (disables the background-contrast/frosted-glass compositing pass).
- `~/.config/plasma-org.kde.plasma.desktop-appletsrc`: add `panelOpacity=1` under your panel's `[Containments][<id>][General]` section to force the panel to Opaque instead of Adaptive/Translucent — this is the single biggest lever for panel-related compositing cost.

The desktop theme itself (`desktoptheme/MacTahoe-Futuristic/plasmarc`) ships `ContrastEffect` and `AdaptiveTransparency` enabled by default, matching upstream MacTahoe-kde behavior — the `panelOpacity=1` override above takes precedence over that per-panel without needing to patch the theme package.

## License

LGPL-3.0, same as upstream — see [`LICENSE`](LICENSE). (Note: upstream's actual license is LGPL-3.0, not GPLv3 — verified against the `vinceliuice/MacTahoe-kde` repository metadata; this fork matches upstream exactly rather than the GPLv3 assumption.) This repository is a palette/icon/cursor fork of vinceliuice's open-source work, not original art; all upstream copyright and attribution is preserved. See [vinceliuice/MacTahoe-kde](https://github.com/vinceliuice/MacTahoe-kde) for the original project.

The staged SDDM theme (`sddm/MacTahoe-Futuristic/`) carries its own original `CC-BY-SA` license notice from upstream, preserved as shipped, with a fork attribution line added to `Copyright=`.
