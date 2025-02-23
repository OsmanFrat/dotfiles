#!/bin/bash

# Bulunduğun dizinin Git repo olup olmadığını kontrol et
if [ ! -d ".git" ]; then
    echo "❌ There is no git repo in this path!"
    exit 1
fi

# Git değişikliklerini kontrol et
if [[ -n $(git status --porcelain) ]]; then
    # Değişiklik varsa commit ve push yap
    git add .
    git commit -m "Auto commit - $(date)"
    git push origin main
    echo "✅ Git repo updated!"
else
    echo "⚡ No changes to commit."
fi
