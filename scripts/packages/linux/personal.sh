#! /bin/bash

source $HOME/scripts/colors.source

anyinstalled=false

if ! dpkg -l signal-desktop 2> /dev/null | grep ii -q; then
    anyinstalled=true
    wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg || logerror"Failed to download signal public key"
    cat signal-desktop-keyring.gpg | sudo tee /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null || logerror"Failed to trust signal public key"
    echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main' | sudo tee /etc/apt/sources.list.d/signal-xenial.list || logerror"Failed to add signal package source"
    sudo apt update && sudo apt install signal-desktop || logerror"Failed to isntall signal"
fi

if [[ $anyinstalled == false ]]; then
    success "All personal packages already installed"
fi
