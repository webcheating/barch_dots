#!/bin/bash

set -e

echo ""
echo "================================"
echo "[*] installing dots"
printf "================================\n\n"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'
error() { echo -e "${RED}[x] $1${NC}"; }
success() { echo -e "${GREEN}[+] $1${NC}"; }
warning() { echo -e "${YELLOW}[!] $1${NC}"; }

sudo pacman -Syu --needed --noconfirm base-devel git


if [ -f /etc/os-release ]; then
    . /etc/os-release
    if [[ "$id" == "arch" ]]; then
        true
    elif [[ "$id" == "artix" ]]; then
        sudo pacman -S artix-archlinux-support
        sudo pacman-key --populate archlinux
        echo -e "[extra]\nInclude = /etc/pacman.d/mirrorlist-arch\n\n[multilib]\nInclude = /etc/pacman.d/mirrorlist-arch"
    else
        echo "unknown distro: $id"
    fi
else
    echo "/etc/os-release error"
fi

if ! command -v yay &> /dev/null && ! command -v paru &> /dev/null; then
    echo "[*] installing aur"
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay && makepkg -si --noconfirm
    cd -
fi

bck_dir=~/cfg_bck_$(date +%Y%m%d_%H%M%S)
echo "[*] backing up existing configs"
mkdir -p $bck_dir
mkdir -p $bck_dir/root
[ -d "~/.config" ] && rsync -av ~/.config $bck_dir/
[ -f "~/.Xresources" ] && rsync -av ~/.Xresources $bck_dir/
[ -f "~/.bashrc" ] && rsync -av ~/.bashrc $bck_dir/
[ -d "/root/.config" ] && sudo rsync -av /root/.config $bck_dir/root/ 
[ -f "/root/.bashrc" ] && sudo rsync -av /root/.bashrc $bck_dir/root/


echo "[*] installing system packages"
# i3-wm i3status python-i3ipc
sudo pacman -S --needed --noconfirm \
    neovim alacritty pcmanfm rofi picom feh scrot xclip xdotool dex \
    brightnessctl firefox playerctl lm_sensors imagemagick xsettingsd \
    python python-pip python-pipx redshift inotify-tools\
    npm jq bc dunst rsync fastfetch pamixer qt5ct cava tex-gyre-fonts obconf-qt lxappearance mousepad xorg-xinput flameshot thunar direnv upower xorg-xset acpi zip unzip

echo "[*] installing fonts..."
sudo pacman -S --needed --noconfirm \
    noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra \
    ttf-jetbrains-mono ttf-fira-code ttf-dejavu \
    ttf-liberation ttf-font-awesome

#if pacman -Qi i3lock &> /dev/null; then
if sudo pacman -Rdd --noconfirm i3lock; then
    echo "[*] removing i3lock (will be replaced by i3lock-color)..."
    #sudo pacman -Rdd --noconfirm i3lock
fi

echo "[*] installing aur packages..."
yay -Syu --needed --noconfirm \
    eww-git \
    mpdris2 \
    ttf-jetbrains-mono-nerd \
    ttf-iosevka-nerd \
    ttf-twemoji \
    ueberzugpp \
    qt6ct-kde \
    i3lock-color \
    m3wal \
    terminus-font-ttf ttf-droid ttf-apple-emoji \
    obmenu-generator

if [ -d "fonts" ]; then
    echo "[*] installing custom fonts"
    FONT_DIR="$HOME/.local/share/fonts"
    mkdir -p "$FONT_DIR"
    cp -rf fonts/* "$FONT_DIR"
    fc-cache -fv
    success "custom fonts installed"
fi

echo "[*] creating directories..."
mkdir -p ~/.config/{rofi,dunst,alacritty,picom,eww,m3-colors,nvim}
mkdir -p ~/.local/{share,bin}
mkdir -p ~/.cache
sudo mkdir -p /root/.config/nvim

if [ -d "config" ]; then
    echo "[*] copying .config/ files..."
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

if [ -d "wallpapers" ]; then
    echo "[*] copying wallpapers"
    mkdir -p ~/Pictures
    [ -d "wallpapers" ] && cp -r wallpapers ~/Pictures/
    success "wallpapers copied"
fi

echo "[*] setting up m3-colors..."
if [ -d "config/m3-colors" ]; then
    cp -r config/m3-colors/* ~/.config/m3-colors/
    success "m3-colors config copied"
else
    warning "[!] m3-colors directory not found, using defaults"
fi

echo "[*] setting permissions..."
find ~/.config -type f \( -name "*.sh" -o -name "*.py" \) -exec chmod +x {} \; 2>/dev/null
#find ~/.config/Scripts -type f -name "*.py" -exec chmod +x {} \; 2>/dev/null
sudo chmod +x ~/.local/bin/* 2>/dev/null || true

echo ""
echo "================================"
echo "[*] initializing m3wal..."
echo "================================"

WALLPAPER=$(find ~/Pictures/wallpapers -type f \( -iname "*.jpg" -o -iname "*.png" \) 2>/dev/null | head -n 1)

if [ -n "$WALLPAPER" ]; then
    echo "[*] applying wallpaper: $WALLPAPER"
    m3wal "$WALLPAPER" --full --mode dark
    success "wallpaper and theme applied"
else
    warning "[!] no wallpaper found, skipping m3wal initialization"
    echo "[!] run 'm3wal /path/to/wallpaper.jpg --full' manually later"
fi

[ -f ".Xresources" ] && cp .Xresources ~/ && success ".Xresources copied"
[ -f ".xprofile" ] && cp .xprofile ~/ && success ".xprofile copied"
[ -f ".bashrc" ] && cp .bashrc ~/ && success ".bashrc copied"
[ -f "root/.bashrc" ] && sudo cp root/.bashrc /root/ && success "root .bashrc copied"
[ -f "00-keyboard.conf" ] && sudo cp 00-keyboard.conf /etc/X11/xorg.conf.d/ && success "00-keyboard.conf copied"
[ -f "x/xprofile" ] && sudo cp x/xprofile /etc/ && success "xprofile copied"
[ -f "../../global_files/.tmux.conf" ] && cp ../../global_files/.tmux.conf ~/ && success ".tmux.conf copied"
[ -d "../../global_files/.tmux" ] && rsync -av --progress ../../global_files/.tmux ~/ && success " .tmux copied"

if [ -d "x" ]; then
    rsync -av --progress x/.x* ~/ && success ".xinitrc & .xserverrc copied"
fi

[ -f "autostart" ] && sudo cp autostart /etc/xdg/openbox/ && success "openbox autostart file copied"

rm -rf ~/.config/nvim/* && sudo rm -rf /root/.config/nvim/*
git clone https://github.com/webcheating/nvim ~/.config/nvim/ && success "nvim config copied"
sudo git clone https://github.com/webcheating/nvim /root/.config/nvim/ && success "nvim config for root copied"
#[ -d "../../global_files/nvim" ] && rsync -av --progress ../../global_files/nvim ~/.config/ && success "nvim config copied"
#[ -d "../../global_files/nvim" ] && sudo rsync -av --progress ../../global_files/nvim /root/.config/ && success "nvim config for root copied"

echo "[*] installing icons and themes"
[ -d "usr_share" ] && sudo rsync -av usr_share/ /usr/share/ && success "icons and themes copied"

echo ""
echo "================================"
echo "[*] reloading openbox..."
echo "================================"

if pgrep -x "i3" > /dev/null; then
    openbox --reconfigure
    #openbox --restart
    success "openbox reloaded successfully"
else
    warning "[!] openbox is not currently running"
    echo "[!] please logout and select openbox as your window manager"
fi

echo ""
echo "================================"
echo "[+] all done"
echo "================================"
echo "[*] backup saved at: $bck_dir"
echo ""
echo "[*] don't forget to to manually configure lxappearance and obconf-qt later ^_^"
echo ""
echo "================================"


#echo "Installed components:"
#echo "  • i3-wm, rofi, dunst, picom"
#echo "  • alacritty, pcmanfm, feh"
#echo "  • firefox, eww, m3wal"
#echo "  • Nerd Fonts & icon fonts"
#echo ""
#echo "Next steps:"
#echo "  1. Logout and login again (or restart)"
#echo "  2. Select i3 as your window manager"
#echo "  3. Change wallpaper: m3wal /path/to/wallpaper.jpg --full"
#echo "  4. Configure m3-colors: ~/.config/m3-colors/m3-colors.conf"
#echo ""
#echo "================================"
