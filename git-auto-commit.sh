#!/bin/bash

# Dotfiles dizinine git
cd ~/dotfiles

# Git değişikliklerini kontrol et
if [[ -n $(git status --porcelain) ]]; then
    # Değişiklik varsa commit ve push yap
    git add .
    git commit -m "Auto commit - $(date)"
    git push origin main
else
    # Değişiklik yoksa sadece mesaj yaz
    echo "No changes to commit."
fi
