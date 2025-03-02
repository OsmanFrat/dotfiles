#!/bin/bash

#### install programs ####
echo "Installing programs..."
cd 

echo "Updating system"
sudo pacman -Syu

echo "Installing..."
sudo pacman -S nvim vim yazi rofi cronie emacs ttf-jetbrains-mono-nerd ttf-firacode zsh starship alacritty qutebrowser firefox waybar hyprpaper less ripgrep lsd bat fzf aria2 jq fd wl-clipboard syncplay pyside6 python-adblock mpv vlc sed curl grep yt-dlp ffmpeg patch
