#!/bin/bash

#### Setup Process ####
echo "Installation started..."

cd ~

echo "Configuring Git..."

read -p "Enter your GitHub username: " git_username
read -p "Enter your GitHub email: " git_email

git config --global user.name "$git_username"
git config --global user.email "$git_email"

echo "Git configuration completed."
echo "Set your new ssh key when installation is ower."

echo "Backing up existing configurations..."
mkdir -p ~/dotfiles_backup
cp -r ~/.config ~/dotfiles_backup/config_$(date +%F)
cp -r ~/.zshrc ~/dotfiles_backup/zshrc_$(date +%F) 2>/dev/null
cp -r ~/.bashrc ~/dotfiles_backup/bashrc_$(date +%F) 2>/dev/null

echo "Deleting the old config files to replace with new ones..."

rm -rf ~/.config/hypr
rm -rf ~/.config/kitty
rm -rf ~/.config/alacritty
rm -rf ~/.config/nvim
rm -rf ~/.config/rofi
rm -rf ~/.config/yazi
rm -rf ~/.config/doom
rm -rf ~/.config/dunst
rm -rf ~/.config/qutebrowser
rm -rf ~/.config/waybar
rm -rf ~/.config/mpv
rm -rf ~/.config/newsboat
rm -rf ~/.config/neofetch
rm -rf ~/.config/Syncplay
rm -rf ~/.config/starship.toml


echo "Cloning dotfiles repository..."
git clone https://github.com/OsmanFrat/dotfiles ~/dotfiles

echo "Updating system..."
sudo pacman -Syu stow --noconfirm

echo "Applying dotfiles with stow..."
mkdir -p ~/Pictures
cd ~/dotfiles/
stow -t ~/.config config
stow -t $HOME shell
stow -t ~/Pictures Pictures

cd ~

echo "Installing apps..."
sudo pacman -S --noconfirm adw-gtk-theme neovim vim newsboat fastfetch unzip 7zip thunar feh zathura imagemagick zoxide poppler wl-clipboard yazi rofi-wayland cronie npm go emacs ttf-jetbrains-mono-nerd ueberzugpp \
ttf-fira-code noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra noto-fonts-emoji \
zsh starship stylua python-black alacritty mpc qutebrowser firefox waybar hyprpaper less ripgrep lsd bat fzf aria2 jq fd \
syncplay pyside6 python-adblock python-mutagen mpv vlc sed curl grep yt-dlp ffmpeg patch github-cli \
steam pavucontrol qbittorent 

echo "Installing yay..."
sudo pacman -S --needed --noconfirm git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si --noconfirm

echo "Installing yay apps..."
yay -S --noconfirm ani-cli hyprshot clipman wlogout

echo "Changing shell to zsh..."
if chsh -s /bin/zsh $(whoami); then
    echo "Shell successfully changed to zsh. Please log out and log back in for changes to take effect."
else
    echo "Failed to change shell. Try running 'chsh -s /bin/zsh' manually."
fi

echo "Adding history settings for zsh..."
mkdir -p ~/.zsh_history


echo "Installing cronie and adding jobs..."

sudo systemctl start cronie
sudo systemctl enable cronie

chmod +x ~/dotfiles/git-auto-commit.sh
chmod +x ~/github/notes/git-auto-commit.sh
chmod +x ~/dotfiles/scripts/battery-alarm.sh
chmod +x ~/dotfiles/scripts/clone-repo.sh
chmod +x ~/dotfiles/scripts/create-repo.sh
chmod +x ~/dotfiles/scripts/fast-commit.sh
chmod +x ~/dotfiles/scripts/linkhandler.sh

(crontab -l 2>/dev/null; echo "*/2 * * * * /home/ozu/github/notes/git-auto-commit.sh") | crontab -
(crontab -l 2>/dev/null; echo "*/2 * * * * /home/ozu/dotfiles/git-auto-commit.sh") | crontab -
(crontab -l 2>/dev/null; echo "*/1 * * * * /home/ozu/dotfiles/scripts/battery-alarm.sh") | crontab -

echo "Installing doom emacs..."
git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
~/.config/emacs/bin/doom install

echo "Setting up Emacs Daemon..."
mkdir -p ~/.config/systemd/user
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

echo ""
echo "Installation completed!"
echo "Please restart your computer."
