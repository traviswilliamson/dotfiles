#! /bin/bash

source $HOME/scripts/colors.source

anyinstalled=false
packagelist=$(winget.exe list)

if ! choco list --limit-output -e signal &> /dev/null; then
    anyinstalled=true
    info "Installing Signal"
    choco install -y signal || logerror "Failed to install Signal"
fi

if ! echo "$packagelist" | grep -q Discord.Discord; then
    anyinstalled=true
    info "Installing Discord"
    winget install --id Discord.Discord -e --accept-package-agreements --accept-source-agreements || logerror "Failed to install Discord"
fi

if ! echo "$packagelist" | grep -q Valve.Steam; then
    anyinstalled=true
    info "Installing Steam"
    winget install --id Valve.Steam -e --accept-package-agreements --accept-source-agreements || logerror "Failed to install Steam"
fi

if ! echo "$packagelist" | grep -q ElectronicArts.EADesktop; then
    anyinstalled=true
    info "Installing EA"
    winget install --id ElectronicArts.EADesktop -e --accept-package-agreements --accept-source-agreements || logerror "Failed to install EA"
fi

if ! echo "$packagelist" | grep -q EpicGames.EpicGamesLauncher; then
    anyinstalled=true
    info "Installing Epic Games"
    winget install --id EpicGames.EpicGamesLauncher -e --accept-package-agreements --accept-source-agreements || logerror "Failed to install Epic Games"
fi

if ! echo "$packagelist" | grep -q GOG.Galaxy; then
    anyinstalled=true
    info "Installing GOG Galaxy"
    winget install --id GOG.Galaxy -e --accept-package-agreements --accept-source-agreements || logerror "Failed to install GOG Galaxy"
fi

if ! choco list --limit-output -e mp3tag &> /dev/null; then
    anyinstalled=true
    info "Installing mp3tag"
    choco install -y mp3tag || logerror "Failed to install mp3tag"
fi

if [[ $anyinstalled == false ]]; then
    success "All personal packages already installed"
fi
