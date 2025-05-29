#!/bin/bash

cd $HOME/dotfiles/scripts
./update-playlist.sh
cd $HOME/Music
mpc clear
mpc add /
mpc play
