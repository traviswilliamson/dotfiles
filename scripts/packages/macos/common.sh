#! /bin/bash

source $HOME/scripts/colors.source

anyinstalled=false

if ! xcode-select --print-path &>/dev/null; then
    anyinstalled=false
    success "Installing XCode command line tools"
    xcode-select --install || logerror "Failed to install XCode command line tools"
fi

# TOOD: hash? check
if ! brew -v &> /dev/null; then
    info "Installing brew"
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || logerror "Failed to install brew"
fi

if ! brew list python &> /dev/null; then
    anyinstalled=false
    info "Installing python"
    brew install python || logerror "Failed to install python"
fi

# TODO: Can you check for taps?
# brew tap-info microsoft/git? What's the output?
tap microsoft/git

if ! brew list git-credential-manager-core &> /dev/null; then
    anyinstalled=false
    info "Installing git credential manager"
    brew install --cask git-credential-manager-core || logerror "Failed to install git credential manager"
fi

if ! brew list brave-browser &> /dev/null; then
    anyinstalled=false
    info "Installing Brave"
    brew install brave-browser || logerror "Failed to install Brave"
fi

if ! brew list visual-studio-code &> /dev/null; then
    anyinstalled=false
    info "Installing VSCode"
    brew install --cask visual-studio-code || logerror "Failed to install VSCode"
fi

if ! brew list dotnet-sdk &> /dev/null; then
    anyinstalled=false
    info "Installing .net SDK"
    brew install --cask dotnet-sdk || logerror "Failed to install .net SDK"
fi

if [[ $anyinstalled == false ]]; then
    success "All common packages already installed"
fi
