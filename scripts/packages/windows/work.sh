#! /bin/bash

source $HOME/scripts/colors.source

anyinstalled=false
packagelist=$(winget.exe list)

if ! echo "$packagelist" | grep -q Microsoft.VisualStudio.2022.Professional; then
    anyinstalled=true
    info "Installing Visual Studio"
    winget install --id Microsoft.VisualStudio.2022.Professional -e --accept-package-agreements --accept-source-agreements || error "Failed to install Visual Studio"
fi

if ! echo "$packagelist" | grep -q suse.RancherDesktop; then
    anyinstalled=true
    info "Installing Rancher"
    winget install --id suse.RancherDesktop -e --accept-package-agreements --accept-source-agreements || error "Failed to install Rancher"
fi

if ! echo "$packagelist" | grep -q Bruno.Bruno; then
    anyinstalled=true
    info "Installing Bruno"
    winget install --id Bruno.Bruno -e --accept-package-agreements --accept-source-agreements || error "Failed to install Bruno"
fi

if ! echo "$packagelist" | grep -q SlackTechnologies.Slack; then
    anyinstalled=true
    info "Installing Slack"
    winget install --id SlackTechnologies.Slack -e --accept-package-agreements --accept-source-agreements || error "Failed to install Slack"
fi

if [ $anyinstalled = false ]; then
    success "All work packages already installed"
fi
