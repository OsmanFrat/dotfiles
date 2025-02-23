eval "$(starship init zsh)"

export EDITOR=nvim
export VISUAL=nvim

alias indir='sudo pacman -S'
alias aur='yay -S'
alias sil='sudo pacman -R'
alias aur-sil='yay -R'
alias yedek='~/dotfiles/git-auto-commit.sh'
alias note-yedek='~/GitHub/notes/git-auto-commit.sh'

alias n='nvim'
alias v='vim'
alias dcon='nvim ~/.config/doom/config.el'
alias ovim='nvim $(fzf)'
alias cf='cat $(fzf) | wl-copy'

alias zcon='nvim ~/.zshrc && source ~/.zshrc'
alias hcon='nvim ~/.config/hypr/hyprland.conf && hyprctl reload'
alias fontr='sudo fc-cache -f -v'
alias c='clear'
alias ls='lsd'
alias ycon='nvim ~/.config/yazi/yazi.toml'
alias ncon='nvim ~/.config/nvim/lua/plugins/init.lua'
alias dcon='nvim ~/.config/doom/config.el'
alias vcon='vim ~/.vimrc && source ~/.vimrc'
alias wcon='nvim ~/.config/waybar/config.jsonc'

# python alias
alias p='python main.py'
alias py='python'
alias penv='python -m venv venv'
alias senv='source venv/bin/activate'

export PATH=$PATH:/usr/local/bin/
export PATH="$HOME/.config/emacs/bin:$PATH"
# Created by `pipx` on 2025-02-22 15:42:32
export PATH="$PATH:/home/ozu/.local/bin"
