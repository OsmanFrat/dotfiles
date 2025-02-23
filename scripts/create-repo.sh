#!/bin/bash

# 1. Yeni repo adı alınacak
echo "Enter new repo name: "
read repo_name

# 2. Public mi Private mi seçeneklerini fzf ile sunalım
# privacy=$(echo -e "private\npublic" | fzf --prompt="Choose privacy setting for $repo_name: ")
privacy=$(echo -e "private\npublic" | fzf --height=6 --border --no-sort --reverse --no-input --bind "enter:accept,j:down,k:up")

# 3. GitHub'da repo oluşturulacak
echo "New repo $repo_name creating..."
gh repo create $repo_name --$privacy

# 4. ~/GitHub klasörü var mı kontrol edelim, yoksa oluşturalım
if [ ! -d "$HOME/GitHub" ]; then
    echo "~/GitHub file does not exist, creating..."
    mkdir ~/GitHub
fi


echo "Waiting for GitHub to update the repository..."
sleep 5 # 10 saniye bekleme

# 5. Reposu klonlanacak kullanci adim OsmanFrat senin ki farkli ise degistir
echo "Repo $repo_name cloning..."
git clone git@github.com:OsmanFrat/$repo_name.git ~/GitHub/$repo_name

# 6. README.md oluşturulmak isteniyor mu sorusu
echo "Do you wanna make a README.md file? (y/n)"
read create_readme

if [[ "$create_readme" == "y" || "$create_readme" == "Y" ]]; then
    echo "Enter a title for README.md: "
    read readme_title
    echo "$readme_title" > ~/GitHub/$repo_name/README.md
    echo "README.md file is created."
fi

# 7. Git işlemleri başlatılacak
cd ~/GitHub/$repo_name

# 8. Git init ve commit işlemleri
git init
git add .
git commit -m "Initial commit"

# 9. Git push işlemi
git push -u origin main

# 10. Sonuçları yazdıralım
echo "$repo_name is created!"
echo "New Repo Name: $repo_name"
echo "Privacy setting: $privacy"
echo "Repo path: ~/GitHub/$repo_name"
