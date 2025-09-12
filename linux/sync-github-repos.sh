#!/usr/bin/env bash

set -x

TIMEOUT=30m
REPO_LIST=(
    "$HOME/project/publishing/savolla.github.io"
    "$HOME/project/scripts"
    "$HOME/project/environ"
)

while true; do
    for repo in "${REPO_LIST[@]}"; do
        cd "$repo" || { echo "Failed to cd into $repo"; continue; }

        if [ -n "$(git status --porcelain)" ]; then
            git add .
            git commit -m "auto: sync $(date "+%Y.%m.%d %H:%M")"
            git push || echo "Push failed for $repo"
        else
            echo "No changes in $repo"
        fi
    done

    # # Dotfiles repo
    # if [ -n "$(
    #     git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME" status --porcelain
    # )" ]; then
    #     git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME" add -A
    #     git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME" commit -m "auto: sync $(date "+%Y.%m.%d %H:%M")"
    #     git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME" push || echo "Dotfiles push failed"
    # else
    #     echo "No changes in dotfiles"
    # fi

    sleep "$TIMEOUT"
done
