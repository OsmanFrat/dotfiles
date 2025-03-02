#!/bin/bash

#### install programs ####
echo "Installation started..."
cd 

echo "Updating system"
sudo pacman -Syu

echo "Installing apps..."
sudo pacman -S nvim vim neofetch yazi rofi cronie emacs ttf-jetbrains-mono-nerd ttf-firacode zsh starship alacritty qutebrowser firefox waybar hyprpaper less ripgrep lsd bat fzf aria2 jq fd wl-clipboard syncplay pyside6 python-adblock mpv vlc sed curl grep yt-dlp ffmpeg patch

echo "Installing yay..."
sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si

echo "Installing yay apps..."
yay -S ani-cli hyprshot
