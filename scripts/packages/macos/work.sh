#! /bin/bash

source $HOME/scripts/colors.source

anyinstalled=false

if ! brew list slack &> /dev/null; then
    anyinstalled=false
    info "Installing Slack"
    brew install --cast slack || error "Failed to install Slack"
fi

if [[ $anyinstalled == false ]]; then
    success "All work packages already installed"
fi
