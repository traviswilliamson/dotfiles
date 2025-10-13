#!/bin/bash

source $HOME/scripts/os.source
source $HOME/scripts/colors.source

DIR=$(dirname "$0")
pushd "$DIR" > /dev/null

# git
gitfiletolink="$HOME/scripts/configs/git/.gitconfig.$(os)"
info "Symlinking .gitconfig.thisos to $gitfiletolink"
ln -sf "$gitfiletolink" "$HOME/.gitconfig.thisos"

# os
info "Configuring OS settings"
bash "./os/$(os).sh"

# VSCode
vscodepath=""
case $(os) in
    "linux")
        vscodepath="$HOME/.config/Code/User"
        ;;
    "windows")
        vscodepath="$APPDATA/Code/User"
        ;;
    "macos")
        vscodepath="$HOME/Library/Application Support/Code/User"
        ;;
esac
info "Symlinking VSCode settings"
mkdir -p "$vscodepath"
ln -Pf "$HOME/scripts/configs/vscode/keybindings.json" "$vscodepath/keybindings.json"
ln -Pf "$HOME/scripts/configs/vscode/settings.json" "$vscodepath/settings.json"

# Something for windows terminal profiles?

popd > /dev/null
