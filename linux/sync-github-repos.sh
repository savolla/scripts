#!/usr/bin/env bash

set -x

TIMEOUT=30m
REPO_LIST=(
    "$HOME/project/publishing/savolla.github.io" # blog
    "$HOME/project/scripts" # scripts
    "$HOME/project/environ" # environ
)

while true
do
    for repo in "${REPO_LIST[@]}"; do
        cd "$repo" || exit
        git add .
        git commit -m "auto: sync $(date "+%Y.%m.%d %H:%M")"
        git push
    done

    # pushing dotfiles
    git --git-dir="$HOME"/.dotfiles/ --work-tree="$HOME" add -A
    git --git-dir="$HOME"/.dotfiles/ --work-tree="$HOME" commit -m "auto: sync $(date "+%Y.%m.%d %H:%M")"
    git --git-dir="$HOME"/.dotfiles/ --work-tree="$HOME" push

    sleep "$TIMEOUT"
done
