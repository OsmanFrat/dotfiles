eval "$(starship init zsh)"
#https://youtu.be/Vj_wCVipuPo?si=mBaIAg9nVRh6pL9H
# System default appps
export EDITOR=nvim
export VISUAL=nvim

# Installation aliasses
alias ekle='sudo pacman -S'
alias sil='sudo pacman -R'
alias temizle='sudo pacman -Rns $(pacman -Qtdq)'
alias guncelle='sudo pacman -Syu'
alias aur='yay -S'
alias aur-sil='yay -R'

# Custom scripts of ozu 
alias yedek='~/dotfiles/git-auto-commit.sh'
alias note-yedek='~/github/notes/git-auto-commit.sh'
alias create-repo='~/dotfiles/scripts/create-repo.sh'
alias fast-commit='~/dotfiles/scripts/git-auto-commit.sh'

# Open settings
alias zcon='nvim ~/.zshrc && source ~/.zshrc'
alias hcon='nvim ~/.config/hypr/hyprland.conf && hyprctl reload'
alias ycon='nvim ~/.config/yazi/yazi.toml'
alias ncon='nvim ~/.config/nvim/'
alias dcon='nvim ~/.config/doom/config.el'
alias vcon='vim ~/.vimrc && source ~/.vimrc'
alias wcon='nvim ~/.config/waybar/config.jsonc'
alias dns='sudo chattr -i /etc/resolv.conf && sudo nvim /etc/resolv.conf && sudo chattr +i /etc/resolv.conf'

# python aliases
alias p='python main.py'
alias py='python'
alias penv='python -m venv venv'
alias senv='source venv/bin/activate'

# General
alias n='nvim'
alias v='vim'
alias c='clear'
alias ls='lsd'
alias cf='cat $(fzf) | wl-copy'
alias fontr='sudo fc-cache -f -v'

# System path idk xd
export PATH=$PATH:/usr/local/bin/
export PATH="$HOME/.config/emacs/bin:$PATH"
export PATH="$PATH:/home/ozu/.local/bin"
