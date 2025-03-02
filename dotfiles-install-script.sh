#!/bin/bash

#### install programs ####
echo "Installation started..."

cd ~

echo "Updating system..."
sudo pacman -Syu --noconfirm || { echo "Pacman update failed"; exit 1; }

echo "Installing apps..."
sudo pacman -S --noconfirm neovim vim fastfetch yazi rofi cronie npm go emacs ttf-jetbrains-mono-nerd ttf-fira-code noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra noto-fonts-emoji zsh starship alacritty qutebrowser firefox waybar hyprpaper less ripgrep lsd bat fzf aria2 jq fd wl-clipboard syncplay pyside6 python-adblock mpv vlc sed curl grep yt-dlp ffmpeg patch github-cli steam pavucontrol || { echo "Pacman install failed"; exit 1; }

echo "Installing yay..."
sudo pacman -S --needed --noconfirm git base-devel || { echo "Pacman base-devel failed"; exit 1; }
git clone https://aur.archlinux.org/yay.git || { echo "Yay cloning failed"; exit 1; }
cd yay || { echo "Failed to cd into yay"; exit 1; }
makepkg -si --noconfirm || { echo "Yay install failed"; exit 1; }

echo "Installing yay apps..."
yay -S --noconfirm ani-cli hyprshot || { echo "Yay apps install failed"; exit 1; }

echo "Installing dotfiles..."
git clone https://github.com/OsmanFrat/dotfiles || { echo "Dotfiles clone failed"; exit 1; }

mkdir -p ~/Pictures
stow -t ~/.config config || { echo "Stow config failed"; exit 1; }
stow -t $HOME shell || { echo "Stow shell failed"; exit 1; }
stow -t ~/Pictures Pictures || { echo "Stow Pictures failed"; exit 1; }

(crontab -l 2>/dev/null; echo "*/2 * * * * /home/ozu/github/notes/git-auto-commit.sh") | crontab -
(crontab -l 2>/dev/null; echo "*/2 * * * * /home/ozu/dotfiles/git-auto-commit.sh") | crontab -

echo "Installing doom emacs..."
git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs || { echo "Doom Emacs clone failed"; exit 1; }
~/.config/emacs/bin/doom install || { echo "Doom install failed"; exit 1; }

doom sync || { echo "Doom sync failed"; exit 1; }

echo "[Unit]
Description=Emacs Daemon

[Service]
ExecStart=/usr/bin/emacs --fg-daemon
Restart=always

[Install]
WantedBy=default.target" > ~/.config/systemd/user/emacs.service

systemctl --user daemon-reload || { echo "Daemon reload failed"; exit 1; }
systemctl --user enable emacs.service || { echo "Failed to enable emacs service"; exit 1; }
systemctl --user start emacs || { echo "Failed to start emacs service"; exit 1; }

# Cron servisini etkinleştir ve başlat
sudo systemctl enable cronie --now || { echo "Cronie service failed"; exit 1; }

echo "Doom emacs installed"
echo "Installation completed!"

