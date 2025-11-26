#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '


### ===== HISTORY =====
HISTFILE=~/.bash_history
HISTSIZE=10000
HISTFILESIZE=10000

# Bash tarih ayarları
# Aynı komutu tekrar yazınca tekrar ekleme
export HISTCONTROL=ignoredups:ignorespace

# Her komut çalıştıkça direkt history'e ekle
shopt -s histappend
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

### ===== EDITOR =====
export EDITOR=nvim
export VISUAL=nvim

### ===== PACMAN & YAY ALIASES =====
alias ekle='sudo pacman -S'
alias sil='sudo pacman -R'
alias pacman-temizlik='sudo pacman -Rns $(pacman -Qtdq)'
alias guncelle='sudo pacman -Syu'
alias aur='yay -S'
alias aur-sil='yay -R'
alias update-discord='sudo pacman -Sy discord'

### ===== CUSTOM SCRIPTS OF OZU =====
alias yedek='~/dotfiles/git-auto-commit.sh'
alias note-yedek='~/github/notes/git-auto-commit.sh'
alias create-repo='~/dotfiles/scripts/create-repo.sh'
alias clone-repo='~/dotfiles/scripts/clone-repo.sh'
alias fast-commit='~/dotfiles/scripts/fast-commit.sh'
alias cheat='~/dotfiles/scripts/cht-fzf.sh'
alias update-playlist='~/dotfiles/scripts/update-playlist.sh'
alias ozumus='~/dotfiles/scripts/ozumus.sh'

### ===== CONFIG SHORTCUTS =====
alias zcon='nvim ~/.bashrc && source ~/.bashrc'
alias hcon='nvim ~/.config/hypr/hyprland.conf && hyprctl reload'
alias ycon='nvim ~/.config/yazi/yazi.toml'
alias ncon='nvim ~/.config/nvim/init.vim'
alias dcon='nvim ~/.emacs.d/init.el'
alias vcon='vim ~/.vimrc && source ~/.vimrc'
alias wcon='nvim ~/.config/waybar/config.jsonc'
alias dns='sudo chattr -i /etc/resolv.conf && sudo -E nvim /etc/resolv.conf && sudo chattr +i /etc/resolv.conf'
alias sop='cd ~/dotfiles/scripts/ && nvim .'
alias pop='cd $(ls -d ~/github/*/ | fzf)'
alias not='nvim ~/github/new-notes/notes.norg'

### ===== PYTHON ALIASES =====
alias py='python'

### ===== GENERAL =====
alias n='nvim'
alias v='vim'
alias c='clear'
alias ls='lsd'
alias cf='fd . . --type f -H | fzf --preview "bat --style=numbers --color=always --theme=TwoDark {}" --preview-window=right:50% | xargs -r cat | wl-copy'
alias fontr='sudo fc-cache -f -v'
alias rss='newsboat'
alias trash='cd ~/.local/share/Trash/files/'
alias clean-trash='sudo rm -rf ~/.local/share/Trash/{files,info}/*'

### ===== CUSTOM SCRIPTS PART 2 =====
alias ozusub='/home/ozu/github/subtitle-downloader/ozusub.sh'

### ===== PATHS =====
export PATH="$PATH:/usr/local/bin/"
export PATH="$HOME/.config/emacs/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
