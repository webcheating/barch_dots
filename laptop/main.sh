#!/bin/bash

#if [ "$(id -u)" -ne 0 ]; then
#  echo "[x] i dont have root privs :("
#  exit 1
#fi

sudo pacman -Syuv && sudo pacman -Syuv --needed base-devel git

echo '[*] installing aur...'
git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si && cd .. && sudo rm -r yay

echo '[*] installing packages...'
#yay -Syuv obmenu-generator lxappearance-obconf mousepad feh xorg-xinput flameshot tint2 thunar
yay -Syuv --noconfirm obmenu-generator lxappearance-gtk3 mousepad feh xorg-xinput flameshot tint2 thunar nvim direnv

echo '[*] installing fonts...'
yay -S --noconfirm ttf-jetbrains-mono ttf-jetbrains-mono-nerd terminus-font-ttf ttf-dejavu ttf-droid ttf-liberation ttf-apple-emoji

echo '[*] installing icons and themes...'
sudo mv /usr/share/themes /usr/share/bck.themes && sudo cp -r usr_share/themes /usr/share/
sudo mv /usr/share/icons /usr/share/bck.icons && sudo mkdir /usr/share/icons && sudo cp -r usr_share/icons/Papirus-Dark /usr/share/icons/

sudo cp 00-keyboard.conf /etc/X11/xorg.conf.d/
sudo cp new/xprofile /etc/
cp new/.xinitrc ~/
cp new/.xserverrc ~/
#sudo cp etc/X11_xinit/xinitrc /etc/X11/xinit/
#sudo cp etc/xprofile /etc/

cp .Xresources ~/
cp .bashrc ~/

echo '[*] setting up .config'
cp -r config/alacritty ~/.config/
cp -r config/nvim ~/.config/
cp -r config/tint2 ~/.config/
cp -r config/obmenu-generator ~/.config/
cp -r config/openbox ~/.config/

sudo cp config/openbox/autostart /etc/xdg/openbox/

sudo cp root/.bashrc /root/
sudo cp -r config/nvim /root/.config/
#sudo rm -r /root/.vim
# sudo cp root/.sliver /root/

echo '[*] setting up wallpapers...'
sudo mkdir -p /usr/share/wallpapers/blackarch-artwork && sudo cp wallpapers/wallpaper-fog.jpg /usr/share/wallpapers/blackarch-artwork/

echo '[*] dont forget to manualy configure lxappearance ^_^'
