# history
HISTFILE=~/.zsh_history

HISTSIZE=10000
SAVEHIST=10000

setopt HIST_IGNORE_DUPS
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_SAVE_NO_DUPS

# System default appps
export EDITOR=nvim
export VISUAL=nvim

# Installation aliasses
alias ekle='sudo pacman -S'
alias sil='sudo pacman -R'
alias pacman-temizlik='sudo pacman -Rns $(pacman -Qtdq)'
alias guncelle='sudo pacman -Syu'
alias aur='yay -S'
alias aur-sil='yay -R'
alias update-discord='sudo pacman -Sy discord'

# Custom scripts of ozu 
alias yedek='~/dotfiles/git-auto-commit.sh'
alias note-yedek='~/github/notes/git-auto-commit.sh'
alias create-repo='~/dotfiles/scripts/create-repo.sh'
alias clone-repo='~/dotfiles/scripts/clone-repo.sh'
alias fast-commit='~/dotfiles/scripts/fast-commit.sh'
alias cheat='~/dotfiles/scripts/cht-fzf.sh'
alias update-playlist='~/dotfiles/scripts/update-playlist.sh'
alias ozumus='~/dotfiles/scripts/ozumus.sh'

# Open settings
alias zcon='nvim ~/.zshrc && source ~/.zshrc'
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

# python aliases
alias py='python'

# General
alias n='nvim'
alias v='vim'
alias c='clear'
alias ls='lsd'
alias cf='fd . . --type f -H | fzf --preview "bat --style=numbers --color=always --theme=TwoDark {}" --preview-window=right:50% | xargs -r cat | wl-copy'
alias fontr='sudo fc-cache -f -v'
alias rss='newsboat'
alias trash='cd ~/.local/share/Trash/files/'
alias clean-trash='sudo rm -rf ~/.local/share/Trash/{files,info}/*'

# ozu custom scripts part 2
alias ozusub='/home/ozu/github/subtitle-downloader/ozusub.sh'

# System paths idk xd
export PATH=$PATH:/usr/local/bin/
export PATH="$HOME/.config/emacs/bin:$PATH"
export PATH="$PATH:/home/ozu/.local/bin"
fpath=(~/.zsh.d/ $fpath)
export PATH="$HOME/.cargo/bin:$PATH"
