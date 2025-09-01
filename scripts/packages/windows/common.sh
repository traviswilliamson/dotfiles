#! /bin/bash

source $HOME/scripts/colors.source

anyinstalled=false
packagelist=$(winget.exe list)

if ! echo "$packagelist" | grep -q Chocolatey.Chocolatey; then
    anyinstalled=true
    info "Installing choco"
    winget install --id Chocolatey.Chocolatey -e --source winget --accept-package-agreements --accept-source-agreements || error "Failed to install choco"
    choco upgrade chocolatey || error "Failed to upgrade choco"
fi

if ! echo "$packagelist" | grep -q Brave.Brave; then
    anyinstalled=true
    info "Installing Brave"
    winget install --id Brave.Brave -e --source winget --accept-package-agreements --accept-source-agreements || error "Failed to install Brave"
fi

# Communication
if ! echo "$packagelist" | grep -q WhatsApp; then
    anyinstalled=true
    info "Installing WhatsApp"
    winget install WhatsApp --source winget --accept-package-agreements --accept-source-agreements || error "Failed to install WhatsApp"
fi

if ! choco list --limit-output -e signal &> /dev/null; then
    anyinstalled=true
    info "Installing Signal"
    choco install -y signal || error "Failed to install Signal"
fi

# OS utilities
if ! echo "$packagelist" | grep -q Microsoft.PowerToys; then
    anyinstalled=true
    info "Installing Powertoys"
    winget install --id Microsoft.PowerToys -e --source winget --accept-package-agreements --accept-source-agreements || error "Failed to install Powertoys"
fi

if ! echo "$packagelist" | grep -q 7zip.7zip; then
    anyinstalled=true
    info "Installing 7zip"
    winget install --id 7zip.7zip -e --accept-package-agreements --accept-source-agreements || error "Failed to install 7zip"
fi

# Dev tools
if ! echo "$packagelist" | grep -q Microsoft.VisualStudioCode; then
    anyinstalled=true
    info "Installing VSCode"
    winget install --id Microsoft.VisualStudioCode -e --source winget --accept-package-agreements --accept-source-agreements || error "Failed to install VSCode"
fi

if ! echo "$packagelist" | grep -q Neovim.Neovim; then
    anyinstalled=true
    info "Installing Neovim"
    winget install --id Neovim.Neovim -e --accept-package-agreements --accept-source-agreements  || error "Failed to install Neovim"
fi

if ! echo "$packagelist" | grep -q Microsoft.WindowsTerminal; then
    anyinstalled=true
    info "Installing Windows Terminal"
    winget install --id Microsoft.WindowsTerminal -e --accept-package-agreements --accept-source-agreements || error "Failed to install Windows Terminal"
fi

if ! choco list --limit-output -e firacode &> /dev/null; then
    anyinstalled=true
    info "Installing Firacode"
    choco install -y firacode || error "Failed to install Firacode"
fi

if ! echo "$packagelist" | grep -q ajeetdsouza.zoxide; then
    anyinstalled=true
    info "Installing zoxide"
    winget install --id ajeetdsouza.zoxide -e --accept-package-agreements --accept-source-agreements || error "Failed to install zoxide"
fi

# Productivity
if ! echo "$packagelist" | grep -q Bitwarden.Bitwarden; then
    anyinstalled=true
    info "Installing Bitwarden"
    winget install --id Bitwarden.Bitwarden -e --accept-package-agreements --accept-source-agreements || error "Failed to install Bitwarden"
fi

if ! echo "$packagelist" | grep -q OBSProject.OBSStudio; then
    anyinstalled=true
    info "Installing OBS"
    winget install --id OBSProject.OBSStudio -e --accept-package-agreements --accept-source-agreements || error "Failed to install OBS"
fi

# Languages
if ! echo "$packagelist" | grep -q Microsoft.DotNet.SDK.8; then
    anyinstalled=true
    info "Installing .net 8 SDK"
    winget install --id Microsoft.DotNet.SDK.8 -e --accept-package-agreements --accept-source-agreements || error "Failed to install .net 8 SDK"
fi

if ! echo "$packagelist" | grep -q Python.Python.3.11; then
    anyinstalled=true
    info "Installing python"
    winget install --id Python.Python.3.11 -e --accept-package-agreements --accept-source-agreements || error "Failed to install python"
fi

if [[ $anyinstalled == false ]]; then
    success "All common packages already installed"
fi
