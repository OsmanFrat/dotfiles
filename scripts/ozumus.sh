#!/bin/bash

# without an argument - just update local songs and play in a random order
if [ $# -eq 0 ]; then
  cd "$HOME/Muzic" || { echo "Error: Could not cd to $HOME/Muzic"; exit 1; }
  mpc clear
  mpc add /
  mpc play
  exit 0
fi

# -r argument - run ./update-playlist.sh script to checking new songs in youtube op(song) playlist



cd $HOME/dotfiles/scripts
./update-playlist.sh
cd $HOME/Music
mpc clear
mpc add /
mpc play



