#!/bin/bash

topic_constraint="none"

# Argümanları işleme
while [[ "$#" -gt 0 ]]; do
    case $1 in
        l|lang)
            topic_constraint="lang"
            shift ;;
        *)
            echo "Invalid option: $1"
            exit 1 ;;
    esac
done

# Konu seçimi
topic=""
if [[ "$topic_constraint" == "lang" ]]; then
    topic=$(printf "go\nrust\nc" | fzf)
    stty sane
else
    topic=$(curl -s cht.sh/:list | fzf)
    stty sane
fi

# Eğer konu seçilmediyse çıkış yap
if [[ -z "$topic" ]]; then
    echo "No topic selected. Exiting."
    exit 0
fi

# Konunun alt konulara sahip olup olmadığını kontrol et
subtopics=$(curl -s cht.sh/"$topic"/:list)

if [[ -z "$subtopics" ]]; then
    # Eğer alt konu yoksa, doğrudan arama yap
    curl -s cht.sh/"$topic"?style=rrt | less -R
    exit 0
fi

# Alt konu seçimi
sheet=$(echo "$subtopics" | fzf)

# Eğer sayfa seçilmediyse sadece konuyu göster
if [[ -z "$sheet" ]]; then
    curl -s cht.sh/"$topic"?style=rrt | less -R
    exit 0
fi

# Konu ve alt konu için tam sonuç gösterimi
curl -s cht.sh/"$topic"/"$sheet"?style=rrt | less -R
