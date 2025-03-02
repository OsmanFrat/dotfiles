#!/bin/bash

#### install programs ####
echo "Installation started..."

cd ~

echo "Updating system..."
sudo pacman -Syu --noconfirm

echo "Installing apps..."
sudo pacman -S --noconfirm nvim vim neofetch yazi rofi cronie emacs ttf-jetbrains-mono-nerd ttf-firacode zsh starship alacritty qutebrowser firefox waybar hyprpaper less ripgrep lsd bat fzf aria2 jq fd wl-clipboard syncplay pyside6 python-adblock mpv vlc sed curl grep yt-dlp ffmpeg patch github-cli steam

echo "Installing yay..."
sudo pacman -S --needed --noconfirm git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si --noconfirm

echo "Installing yay apps..."
yay -S --noconfirm ani-cli hyprshot

echo "Installing doom emacs..."
git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
~/.config/emacs/bin/doom install

echo "Installing dotfiles..."
git clone https://github.com/OsmanFrat/dotfiles

mkdir -p Pictures
stow -t ~/.config config
stow -t $HOME shell
stow -t ~/Pictures Pictures



echo "Installation completed!"

