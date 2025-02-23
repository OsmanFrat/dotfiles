#!/bin/bash

# Bulunduğun dizinin Git repo olup olmadığını kontrol et
if [ ! -d ".git" ]; then
    echo "❌ Bu dizin bir Git deposu değil!"
    exit 1
fi

# Git değişikliklerini kontrol et
if [[ -n $(git status --porcelain) ]]; then
    # Değişiklik varsa commit ve push yap
    git add .
    git commit -m "Auto commit - $(date)"
    git push origin main
    echo "✅ Git deposu güncellendi!"
else
    echo "⚡ No changes to commit."
fi
