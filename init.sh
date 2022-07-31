#!/usr/bin/env bash

DOTFILES_DIR="${HOME}/.dotfiles"
DOTFILES_REPO="git@github.com:mehrenreich/dotfiles.git"
INSTALL_DOTFILES=true

if [[ ! -d $DOTFILES_DIR ]]
then
    git clone $DOTFILES_REPO $DOTFILES_DIR
else
    cd $DOTFILES_DIR
    git pull
fi

if [[ -x $DOTFILES_DIR/install.sh ]] && [[ $INSTALL_DOTFILES == true ]]
then
    echo "running the installer"
    # $DOTFILES_DIR/install.sh
fi
