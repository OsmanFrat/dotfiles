#!/bin/bash

#### install programs ####
echo "Installation started..."

cd ~

echo "Updating system..."
sudo pacman -Syu --noconfirm

echo "Installing apps..."
sudo pacman -S --noconfirm neovim vim neofetch yazi rofi cronie npm go emacs ttf-jetbrains-mono-nerd ttf-fira-code zsh starship alacritty qutebrowser firefox waybar hyprpaper less ripgrep lsd bat fzf aria2 jq fd wl-clipboard syncplay pyside6 python-adblock mpv vlc sed curl grep yt-dlp ffmpeg patch github-cli steam pavucontrol

echo "Installing yay..."
sudo pacman -S --needed --noconfirm git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si --noconfirm

echo "Installing yay apps..."
yay -S --noconfirm ani-cli hyprshot noto-fonts-cjk

echo "Installing dotfiles..."
git clone https://github.com/OsmanFrat/dotfiles

mkdir -p ~/Pictures
stow -t ~/.config config
stow -t $HOME shell
stow -t ~/Pictures Pictures

(crontab -l 2>/dev/null; echo "*/2 * * * * /home/ozu/github/notes/git-auto-commit.sh") | crontab -
(crontab -l 2>/dev/null; echo "*/2 * * * * /home/ozu/dotfiles/git-auto-commit.sh") | crontab -

echo "Installing doom emacs..."
git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
~/.config/emacs/bin/doom install

doom sync

echo "[Unit]
Description=Emacs Daemon

[Service]
ExecStart=/usr/bin/emacs --fg-daemon
Restart=always

[Install]
WantedBy=default.target" > ~/.config/systemd/user/emacs.service

systemctl --user daemon-reload
systemctl --user enable emacs
systemctl --user start emacs

echo "Doom emacs installed"

echo "Installation completed!"

