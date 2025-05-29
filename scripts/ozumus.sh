#!/bin/bash

function update_local_song_and_play {
  cd "$HOME/Music" || { echo "Error: Could not cd to $HOME/Muzic"; exit 1; }
  mpc clear
  mpc add /
  mpc play
}


# without an argument - just update local songs and play in a random order
if [ $# -eq 0 ]; then
  update_local_song_and_play
  exit 0
fi

# -r argument - run ./update-playlist.sh script to checking new songs in youtube op(song) playlist
while getopts ":r" opt; do
  case $opt in
    r)
      # run ./update-playlist.sh if -r is passed
      if [ -f "$HOME/dotfiles/scripts/update-playlist.sh" ]; then
        $HOME/dotfiles/scripts/update-playlist.sh
        update_local_song_and_play
      else
        echo "Error: $HOME/dotfiles/scripts/update-playlist.sh is not found!"
        exit 1
      fi
      exit 0
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
  esac
done

