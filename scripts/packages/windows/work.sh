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

if ! echo "$packagelist" | grep -q Microsoft.devtunnel; then
    anyinstalled=true
    info "Installing devtunnel"
    winget install --id Microsoft.devtunnel -e --accept-package-agreements --accept-source-agreements || error "Failed to install devtunnel"
fi

if ! echo "$packagelist" | grep -q Microsoft.AzureCLI; then
    anyinstalled=true
    info "Installing Azure CLI"
    winget install --id Microsoft.AzureCLI -e --accept-package-agreements --accept-source-agreements || error "Failed to install Azure CLI"
fi

if ! choco list --limit-output -e beyondcompare &> /dev/null; then
    anyinstalled=true
    info "Installing Beyond Compare"
    choco install -y beyondcompare --version=4.4.7.20240301 || error "Failed to install Beyond Compare"
fi

if ! choco list --limit-output -e filezilla &> /dev/null; then
    anyinstalled=true
    info "Installing FileZilla"
    choco install -y filezilla || error "Failed to install FileZilla"
fi

if [[ $anyinstalled == false ]]; then
    success "All work packages already installed"
fi
