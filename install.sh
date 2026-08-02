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

cat <<EOF

--------------------------------------------------------------------
All user-space components installed. To finish:

1. Apply via System Settings > Appearance > Global Theme
   (select "MacTahoe-Futuristic"), or per-component in the relevant
   Appearance sub-pages (Colors, Icons, Cursors, Window Decorations,
   Plasma Style).

2. SDDM login theme (needs root, NOT done by this script):

     sudo cp -r "$REPO_DIR/sddm/MacTahoe-Futuristic" /usr/share/sddm/themes/MacTahoe-Futuristic

   then set it in /etc/sddm.conf.d/*.conf under [Theme] Current=MacTahoe-Futuristic
   (or via System Settings > SDDM if the KCM is installed).
--------------------------------------------------------------------
EOF
