#!/usr/bin/env bash

TIMEOUT=30m
REPO_LIST=(
    "$HOME/project/publishing/savolla.github.io" # blog
    "$HOME/project/scripts" # scripts
    "$HOME/project/environ" # environ
)
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

while true
do
    for repo in "${REPO_LIST[@]}"; do
        cd "$repo" || exit
        git add .
        git commit -m "auto: sync $(date "+%Y.%m.%d %H:%M")"
        git push
    done

    # pushing dotfiles
    dotfiles add -A
    dotfiles commit -m "auto: sync $(date "+%Y.%m.%d %H:%M")"
    dotfiles push

    sleep "$TIMEOUT"
    echo "[INFO] Waiting for $TIMEOUT"
done
