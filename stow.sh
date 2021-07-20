#!/usr/bin/env bash

## what directories should be installable by all users including the root user
base=(
    bash
    dircolors
    inputrc
    zsh
)

## folders that should, or only need to be installed for a local user
useronly=(
    bin
    conda
    direnv
    git
    gnupg
    htop
    psd
    r
    ranger
    sublime-text
    youtube-dl
)

## run the stow command for the passed in directory ($2) in location $1
stowit() {
    loc=$1
    app=$2
    echo "--> Stowing ${app}..."
    stow --restow --target ${loc} ${app}
}

echo "=> Stowing apps for user: $(whoami)"

## make sure we have pulled in and updated any submodules
git submodule init
git submodule update

## install apps available to local users and root
for app in ${base[@]}; do
    stowit "${HOME}" $app
done

## install only user space folders
for app in ${useronly[@]}; do
    if [[ ! "$(whoami)" = *"root"* ]]; then
        stowit "${HOME}" $app
    fi
done

echo ""
echo "=> ALL DONE"
