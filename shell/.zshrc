eval "$(starship init zsh)"

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
alias p='python main.py'
alias pt='python test.py'
alias py='python'
alias penv='python -m venv venv'
alias senv='source venv/bin/activate'

# C programing
alias cb='cmake --build build && cd build/ && ./game'


# Cpp
# alias rcpp='file=$(find . -type f -name "*.cpp" | fzf) && g++ -std=c++17 "$file" -o "${file%.*}" && "${file%.*}"'
alias rcpp='file=$(find . -type f -name "*.cpp" | fzf) && echo "\033[1;34mCompiling: $file\033[0m" && g++ -std=c++17 "$file" -o "${file%.*}" && echo "\033[1;32mRunning:\033[0m" && "${file%.*}" || echo "\033[1;31mDerleme hatası!\033[0m"'



# General
alias n='nvim'
alias v='vim'
alias c='clear'
alias ls='lsd'
# alias cf='cat $(fzf) | wl-copy'
alias cf='fd . . --type f -H | fzf --preview "bat --style=numbers --color=always --theme=TwoDark {}" --preview-window=right:50% | xargs -r cat | wl-copy'
alias fontr='sudo fc-cache -f -v'
alias rss='newsboat'
alias trash='cd ~/.local/share/Trash/files/'
alias clean-trash='sudo rm -rf ~/.local/share/Trash/{files,info}/*'

# ozu custom scripts part 2
alias ozusub='/home/ozu/github/subtitle-downloader/ozusub.sh'

# yt-dlp
alias yt='function _yt(){
    echo "All yt commands cheetsheet:"
    echo ""
    echo "ytdown: YouTube videolarini 1080px, eger yoksa da videosun sahip oldugu en yuksek kalitede indirmeye yarar."
    echo "Kullanım: ytdown <YouTube linki>"
    echo "-----------------------------------------------------------------------------------------------------------"
    echo "ytvop: YouTube videolarini mpv uzerinden goruntulu olarak acar."
    echo "Kullanım: ytvop <YouTube linki> <dk:sn>"
    echo "-----------------------------------------------------------------------------------------------------------"
    echo "ytsop: YouTube videosunu istenen dakika ve saniyede sadece ses dosyasi olarak mpv de baslatir."
    echo "Kullanım: ytsop <YouTube linki> <dk:sn>"
 
}; _yt'


alias ytdown='function _ytdown() {
  if [ "$1" = "-h" ] || [ "$1" = "--help" ] || [ -z "$1" ]; then
    echo "ytdown: YouTube videolarini 1080px, eger yoksa da videosun sahip oldugu en yuksek kalitede indirmeye yarar."
    echo "Kullanım: ytdown <YouTube linki>"
    return 1
  fi
  yt-dlp -f "137+251/bestvideo+bestaudio" --merge-output-format mp4 -o "%(title)s.%(ext)s" "$1"
}; _ytdown'


alias ytvop='function _ytvop() {
  if [ "$1" = "-h" ] || [ "$1" = "--help" ] || [ -z "$1" ]; then
    echo "ytvop: YouTube videolarini mpv uzerinden goruntulu olarak acar."
    echo "Kullanım: ytvop <YouTube linki>"
    return 1
  fi
 
  yt-dlp -f "bestvideo[height<=1080]+bestaudio/best" "$1" -o - | mpv - --force-seekable=yes;
}; _ytvop'

alias ytsop='function _ytsop() {
  if [ "$1" = "-h" ] || [ "$1" = "--help" ] || [ -z "$1" ]; then
    echo "ytsop: YouTube videolarini sadece ses dosyasi olarak mpv player ile acar."
    echo "Kullanım: ytsop <YouTube linki>"
    return 1
  fi
  yt-dlp -f bestaudio "$1" -o - | mpv --no-video - --force-seekable=yes
}; _ytsop'

alias ytscon='function _ytscon() {
  if [ "$1" = "-h" ] || [ "$1" = "--help" ] || [ -z "$1" ] || [ -z "$2" ]; then
    echo "ytsop: YouTube videosunu istenen dakika ve saniyede sadece ses dosyasi olarak mpv de baslatir."
    echo "Kullanım: ytsop <YouTube linki> <dk:sn>"
    return 1
  fi
  yt-dlp -f bestaudio "$1" -o - | mpv --no-video - --force-seekable=yes --start="$2";
}; _ytscon'

# System paths idk xd
export PATH=$PATH:/usr/local/bin/
export PATH="$HOME/.config/emacs/bin:$PATH"
export PATH="$PATH:/home/ozu/.local/bin"
fpath=(~/.zsh.d/ $fpath)
export PATH="$HOME/.cargo/bin:$PATH"
