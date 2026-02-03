#!/bin/bash

set -e

echo "================================"
echo "[*] installing Dotfiles"
printf "================================\n\n"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'
error() { echo -e "${RED}[x] $1${NC}"; }
success() { echo -e "${GREEN}[+] $1${NC}"; }
warning() { echo -e "${YELLOW}[!] $1${NC}"; }

sudo pacman -Syu --needed --noconfirm base-devel git

if ! command -v yay &> /dev/null && ! command -v paru &> /dev/null; then
    echo "[*] installing aur"
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay && makepkg -si --noconfirm
    cd -
fi

bck_dir=~/cfg_bck_$(date +%Y%m%d_%H%M%S)
echo "[*] backing up existing configs"
mkdir -p $bck_dir
[ -d ~/.config ] && cp -r ~/.config $bck_dir/
[ -f ~/.Xresources ] && cp ~/.Xresources $bck_dir/

echo "[*] installing system packages"
sudo pacman -S --needed --noconfirm \
    i3-wm i3status alacritty pcmanfm rofi picom feh scrot xclip xdotool dex \
    brightnessctl firefox playerctl lm_sensors imagemagick xsettingsd \
    python python-pip python-pipx redshift inotify-tools\
    jq bc dunst rsync fastfetch pamixer python-i3ipc qt5ct cava tex-gyre-fonts 

echo "[*] installing fonts..."
sudo pacman -S --needed --noconfirm \
    noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra \
    ttf-jetbrains-mono ttf-fira-code ttf-dejavu \
    ttf-liberation ttf-font-awesome

if pacman -Qi i3lock &> /dev/null; then
    echo "[*] removing i3lock (will be replaced by i3lock-color)..."
    sudo pacman -Rdd --noconfirm i3lock
fi

echo "Installing AUR packages..."
yay -Syu --needed --noconfirm \
    eww-git \
    mpdris2 \
    ttf-jetbrains-mono-nerd \
    ttf-iosevka-nerd \
    ttf-twemoji \
    ueberzugpp \
    qt6ct-kde \
    i3lock-color \
    m3wal

if [ -d "fonts" ]; then
    echo "[*] installing custom fonts"
    FONT_DIR="$HOME/.local/share/fonts"
    mkdir -p "$FONT_DIR"
    cp -rf fonts/* "$FONT_DIR"
    fc-cache -fv
    success "Custom fonts installed"
fi

echo "[*] creating directories..."
mkdir -p ~/.config/{i3,rofi,dunst,alacritty,picom,eww,m3-colors}
mkdir -p ~/.local/{share,bin}
mkdir -p ~/.cache

echo "[*] copying dotfiles..."
if [ -d "config" ]; then
    rsync -av --exclude='*.tmp' config/ ~/.config/
    success "config copied"
fi

if [ -d "local/share" ]; then
    echo "[*] copying local/share files"
    mkdir -p ~/.local/share
    rsync -av --exclude='pipx' local/share/ ~/.local/share/
    success "local/share copied"
fi

if [ -d "local/bin" ]; then
    echo "[*] copying scripts from .local/bin"
    mkdir -p ~/.local/bin
    find local/bin -maxdepth 1 -type f -exec cp {} ~/.local/bin/ \;
    success "scripts copied"
fi

[ -f ".Xresources" ] && cp .Xresources ~/
[ -f ".xprofile" ] && cp .xprofile ~/


if [ -d "wallpapers" ]; then
    echo "[*] copying wallpapers"
    mkdir -p ~/Pictures
    [ -d "wallpapers" ] && cp -r wallpapers ~/Pictures/
    success "wallpapers copied"
fi

echo "[*] setting up m3-colors..."
if [ -d "m3-colors" ]; then
    cp -r m3-colors/* ~/.config/m3-colors/
    success "m3-colors config copied"
else
    warning "m3-colors directory not found, using defaults"
fi

echo "[*] setting permissions..."
find ~/.config -type f \( -name "*.sh" -o -name "*.py" \) -exec chmod +x {} \; 2>/dev/null
find ~/.config/Scripts -type f -name "*.py" -exec chmod +x {} \; 2>/dev/null
sudo chmod +x ~/.local/bin/* 2>/dev/null || true

echo ""
echo "================================"
echo "[*] initializing m3wal..."
echo "================================"

WALLPAPER=$(find ~/Pictures/wallpapers -type f \( -iname "*.jpg" -o -iname "*.png" \) 2>/dev/null | head -n 1)

if [ -n "$WALLPAPER" ]; then
    echo "[*] applying wallpaper: $WALLPAPER"
    m3wal "$WALLPAPER" --full
    success "wallpaper and theme applied"
else
    warning "no wallpaper found, skipping m3wal initialization"
    echo "[!] run 'm3wal /path/to/wallpaper.jpg --full' manually later"
fi

echo ""
echo "================================"
echo "[*] reloading i3..."
echo "================================"

if pgrep -x "i3" > /dev/null; then
    i3-msg restart
    success "i3 reloaded successfully"
else
    warning "i3 is not currently running"
    echo "[!] please logout and select i3 as your window manager"
fi

echo ""
echo "================================"
echo "[+] installation done"
echo "================================"
echo "Backup saved at: $BACKUP_DIR"
echo ""
echo "Installed components:"
echo "  • i3-wm, rofi, dunst, picom"
echo "  • alacritty, pcmanfm, feh"
echo "  • firefox, eww, m3wal"
echo "  • Nerd Fonts & icon fonts"
echo ""
echo "Next steps:"
echo "  1. Logout and login again (or restart)"
echo "  2. Select i3 as your window manager"
echo "  3. Change wallpaper: m3wal /path/to/wallpaper.jpg --full"
echo "  4. Configure m3-colors: ~/.config/m3-colors/m3-colors.conf"
echo ""
echo "================================"
