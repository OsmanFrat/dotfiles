#!/bin/bash

# without an argument
if [ $# -eq 0 ]; then
  cd "$HOME/Music" || {echo "Error: Could not cd to $HOME/Music"}
  mpc clear
  mpc add /
  mpc play
  exit 0
fi


cd $HOME/dotfiles/scripts
./update-playlist.sh
cd $HOME/Music
mpc clear
mpc add /
mpc play



