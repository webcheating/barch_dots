#!/bin/bash

set -e

#if [ "$(id -u)" -ne 0 ]; then
#  echo "[x] i need root"
#  exit 1
#fi
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'
error() { echo -e "${RED}[x] $1${NC}"; }
success() { echo -e "${GREEN}[+] $1${NC}"; }
warning() { echo -e "${YELLOW}[!] $1${NC}"; }

printf "[*] installing dotfiles...\n\n"

sudo pacman -Syu --needed base-devel git

if ! command -v yay &> /dev/null && ! command -v paru &> /dev/null; then
    echo "[*] installing aur"
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay && makepkg -si --noconfirm
    cd -
fi

bck_dir=~/cfg_bck_$(date +%Y%m%d)
echo '[*] backing up existing configs'
mkdir -p $bck_dir
[ -d ~/.config ] && cp -r ~/.config $bck_dir/
[ -f ~/.Xresources ] && cp ~/.Xresources $bck_dir/

echo '[*] installing packages'
#yay -Syuv obmenu-generator lxappearance-obconf mousepad feh xorg-xinput flameshot tint2 thunar
yay -S --noconfirm --needed obmenu-generator lxappearance mousepad feh xorg-xinput flameshot tint2 thunar nvim direnv rsync alacritty upowet xorg-xset acpi

echo '[*] installing fonts...'
yay -S --noconfirm --needed ttf-jetbrains-mono ttf-jetbrains-mono-nerd terminus-font-ttf ttf-dejavu ttf-droid ttf-liberation ttf-apple-emoji ttf-font-awesome noto-fonts noto-fonts-cjk noto-fonts-extra

echo '[*] installing icons and themes...'
sudo mv /usr/share/themes /usr/share/bck.themes && sudo cp -r usr_share/themes /usr/share/
sudo mv /usr/share/icons /usr/share/bck.icons && sudo mkdir /usr/share/icons && sudo cp -r usr_share/icons/Papirus-Dark /usr/share/icons/

#sudo cp 00-keyboard.conf /etc/X11/xorg.conf.d/
#sudo cp x/xprofile /etc/
#cp x/.xinitrc ~/
#cp x/.xserverrc ~/
#cp .Xresources ~/
#cp .bashrc ~/

#sudo cp etc/X11_xinit/xinitrc /etc/X11/xinit/

[ -f ".Xresources" ] && cp .Xresources ~/
[ -f ".bashrc" ] && cp .bashrc ~/
[ -f "00-keyboard.conf" ] && sudo cp 00-keyboard.conf /etc/X11/xorg.conf.d/
[ -f "x/xprofile" ] && sudo cp x/xprofile /etc/
[ -f "x/.xinitrc" ] && cp x/.xinitrc ~/
[ -f "x/.xserverrc" ] && cp x/.xserverrc ~/
[ -f ".tmux" ] && cp -r .tmux ~/
[ -f ".tmux.conf" ] && cp .tmux.conf ~/

echo '[*] setting up .config'
if [ -d "config" ]; then
    rsync -av --exclude='*.tmp' config/ ~/.config/
    success "[+] .config copied"
fi
#cp -r config/alacritty ~/.config/
#cp -r config/nvim ~/.config/
#cp -r config/tint2 ~/.config/
#cp -r config/obmenu-generator ~/.config/
#cp -r config/openbox ~/.config/

sudo cp config/openbox/autostart /etc/xdg/openbox/

sudo cp root/.bashrc /root/
sudo cp -r config/nvim /root/.config/
#sudo rm -r /root/.vim
# sudo cp root/.sliver /root/

echo '[*] setting up wallpapers...'
sudo mkdir -p /usr/share/wallpapers/blackarch-artwork && sudo cp wallpapers/wallpaper-fog.jpg /usr/share/wallpapers/blackarch-artwork/

echo '=========================================================================='
printf "[*] all done. don't forget to manualy configure lxappearance ^_^\n"
echo '=========================================================================='
