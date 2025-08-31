#! /usr/bin/bash

source $HOME/scripts/os.source
source $HOME/scripts/colors.source

filetolink="$HOME/scripts/configs/git/.gitconfig.$(os)"
info "symlinking .gitconfig.thisos to $filetolink\n"
ln -sf "$filetolink" "$HOME/.gitconfig.thisos"