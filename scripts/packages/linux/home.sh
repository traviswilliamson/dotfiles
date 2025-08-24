#! /bin/bash

source $HOME/scripts/colors.source

anyinstalled=false

# TODO: FIX
if ! hash signal &> /dev/null; then
    anyinstalled=true
    wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg || error "Failed to download signal public key"
    cat signal-desktop-keyring.gpg | sudo tee /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null || error "Failed to trust signal public key"
    echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main' | sudo tee /etc/apt/sources.list.d/signal-xenial.list || error "Failed to add signal package source"
    sudo apt update && sudo apt install signal-desktop || error "Failed to isntall signal"
fi

if [ $anyinstalled = false ]; then
    success "All home packages already installed"
fi
