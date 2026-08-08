#!/usr/bin/env bash
# Installs MacTahoe-Futuristic into the current user's XDG data dirs.
# Never touches system paths (/usr) — the SDDM piece needs root and is
# printed as a manual instruction instead of being silently sudo'd.
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

AURORAE_DIR="$HOME/.local/share/aurorae/themes"
DESKTOPTHEME_DIR="$HOME/.local/share/plasma/desktoptheme"
LOOKANDFEEL_DIR="$HOME/.local/share/plasma/look-and-feel"
COLORSCHEME_DIR="$HOME/.local/share/color-schemes"
ICONS_DIR="$HOME/.local/share/icons"
CURSORS_DIR="$HOME/.icons"

install_component() {
    local src="$1" dst_parent="$2" label="$3"
    mkdir -p "$dst_parent"
    rm -rf "${dst_parent:?}/$(basename "$src")"
    cp -r "$src" "$dst_parent/"
    echo "✓ Installed $label -> $dst_parent/$(basename "$src")"
}

install_component "$REPO_DIR/aurorae/MacTahoe-Futuristic" "$AURORAE_DIR" "Aurorae window decoration"
install_component "$REPO_DIR/desktoptheme/MacTahoe-Futuristic" "$DESKTOPTHEME_DIR" "Plasma desktop theme"
install_component "$REPO_DIR/look-and-feel/com.github.vinceliuice.MacTahoe-Futuristic" "$LOOKANDFEEL_DIR" "Look-and-feel package"
install_component "$REPO_DIR/icons/MacTahoe-Futuristic" "$ICONS_DIR" "Icon theme"
install_component "$REPO_DIR/cursors/MacTahoe-Futuristic-cursors" "$CURSORS_DIR" "Cursor theme"

mkdir -p "$COLORSCHEME_DIR"
cp "$REPO_DIR/color-scheme/MacTahoeFuturistic.colors" "$COLORSCHEME_DIR/"
echo "✓ Installed color scheme -> $COLORSCHEME_DIR/MacTahoeFuturistic.colors"

echo
echo "▶ Applying theme to your current session..."
if command -v plasma-apply-lookandfeel &>/dev/null; then
    plasma-apply-lookandfeel -a com.github.vinceliuice.MacTahoe-Futuristic
    echo "✓ Applied — colors, icons, cursor, window decoration, and Plasma style are all live now."
else
    echo "⚠ plasma-apply-lookandfeel not found — apply manually via System Settings > Appearance > Global Theme."
fi

echo
read -rp "Also install the SDDM login screen theme? [needs sudo] (y/N) " reply
if [[ "$reply" =~ ^[Yy]$ ]]; then
    sudo cp -r "$REPO_DIR/sddm/MacTahoe-Futuristic" /usr/share/sddm/themes/MacTahoe-Futuristic
    conf=/etc/sddm.conf.d/mactahoe-futuristic.conf
    printf '[Theme]\nCurrent=MacTahoe-Futuristic\n' | sudo tee "$conf" > /dev/null
    echo "✓ SDDM theme installed and set active in $conf"
else
    echo "  Skipped. Run this later if you change your mind:"
    echo "    sudo cp -r \"$REPO_DIR/sddm/MacTahoe-Futuristic\" /usr/share/sddm/themes/"
    echo "    then set [Theme] Current=MacTahoe-Futuristic in /etc/sddm.conf.d/*.conf"
fi

echo
echo "Done."
