eval "$(starship init zsh)"

# System default appps
export EDITOR=nvim
export VISUAL=nvim

# Installation aliasses
alias ekle='sudo pacman -S'
alias temizle='sudo pacman -Rns $(pacman -Qtdq)'
alias aur='yay -S'
alias sil='sudo pacman -R'
alias aur-sil='yay -R'

# Custom scripts of ozu 
alias yedek='~/dotfiles/git-auto-commit.sh'
alias note-yedek='~/GitHub/notes/git-auto-commit.sh'
alias create-repo='~/dotfiles/scripts/create-repo.sh'
alias fast-commit='~/dotfiles/scripts/git-auto-commit.sh'

# Open settings
alias zcon='nvim ~/.zshrc && source ~/.zshrc'
alias hcon='nvim ~/.config/hypr/hyprland.conf && hyprctl reload'
alias ycon='nvim ~/.config/yazi/yazi.toml'
# alias ncon='nvim ~/.config/nvim/'
alias ncon='nvim ~/.config/nvim/init.lua +"lua require(\"nvim-tree.api\").tree.open({ path = \"~/.config/nvim\", current_window = true })"'
alias dcon='nvim ~/.config/doom/config.el'
alias vcon='vim ~/.vimrc && source ~/.vimrc'
alias wcon='nvim ~/.config/waybar/config.jsonc'
alias dnscon='sudo chattr -i /etc/resolv.conf && sudo nvim /etc/resolv.conf'

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
