#!/bin/bash

# GitHub CLI ile repo listesini al ve fzf ile çoklu seçim yap
REPOS=$(gh repo list --limit 1000 --json nameWithOwner --jq '.[].nameWithOwner' | fzf --multi)

# Kullanıcı seçim yapmazsa çık
if [[ -z "$REPOS" ]]; then
    echo "İşlem iptal edildi."
    exit 1
fi

# Hedef klasörü oluştur
TARGET_DIR=~/github
mkdir -p "$TARGET_DIR"

# Seçilen reposu SSH ile klonla
for REPO in $REPOS; do
    SSH_URL="git@github.com:${REPO}.git"
    echo "Cloning: $REPO -> $TARGET_DIR"
    git clone "$SSH_URL" "$TARGET_DIR/$(basename "$REPO")"
done
