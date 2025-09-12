#!/usr/bin/env bash

REPO_LIST=(
    "$HOME/project/publishing/savolla.github.io" # blog
    "$HOME/project/scripts" # scripts
    "$HOME/project/dotfiles" # dotfiles
    "$HOME/project/environ" # environ
)

for repo in "${REPO_LIST[@]}"; do
    cd "$repo" || exit
    git add .
    git commit -m "auto: sync"
    git push
done
