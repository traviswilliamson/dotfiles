#!/bin/bash

source $HOME/scripts/os.source
source $HOME/scripts/colors.source

DIR=$(dirname "$0")
pushd "$DIR" > /dev/null

# git
filetolink="$HOME/scripts/configs/git/.gitconfig.$(os)"
info "Symlinking .gitconfig.thisos to $filetolink"
ln -sf "$filetolink" "$HOME/.gitconfig.thisos"

# os
info "Configuring OS settings"
bash "./os/$(os).sh"

# Something for windows terminal profiles?

popd > /dev/null
