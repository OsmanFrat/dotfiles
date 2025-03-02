#!/bin/bash

#### install programs ####
echo "Installing programs..."
cd 

echo "Updating system"
sudo pacman -Syu

echo "Installing..."
sudo pacman -S nvim vim yazi rofi cronie emacs ttf-jetbrains-mono-nerd ttf-firacode 
