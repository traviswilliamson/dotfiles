#! /bin/bash

source $HOME/scripts/colors.source

info "Updating package list"
sudo apt update
anyinstalled=false

if ! hash curl &> /dev/null; then
    anyinstalled=true
    info "Installing curl"
    sudo apt install curl || error "Failed to install curl"
fi

if ! hash wget &> /dev/null; then
    anyinstalled=true
    info "Installing wget"
    sudo apt-get install wget || error "Failed to install wget"
fi

if ! hash dotnet &> /dev/null; then
    anyinstalled=true
    info "Installing dotnet"
    wget https://packages.microsoft.com/config/debian/12/packages-microsoft-prod.deb -O packages-microsoft-prod.deb || error "Failed to download MS deb file"
    sudo dpkg -i packages-microsoft-prod.deb || error "Failed to install MS deb file"
    rm packages-microsoft-prod.deb
    sudo apt-get update
    sudo apt-get install -y dotnet-sdk-9.0 && success "Installed .net 9 SDK" || error "Failed to install .net 9 SDK"
    sudo apt-get install -y aspnetcore-runtime-8.0 && successs "Installed ASP.Net 8 runtime" || error "Failed to install ASP.Net 8 runtime"
    dotnet dev-certs https --trust && success "Trusted .net dev cert" || error "Failed to trust .net dev-certs"
fi


if ! dotnet tool list -g git-credential-manager &> /dev/null; then
    anyinstalled=true
    info "Installing git-credential-manager"
    dotnet tool install -g git-credential-manager || error "Failed to install git credential manageR"
    git-credential-manager configure || error "Failed to configure git credential manager"
    sudo dotnet workload update || error "Failed to update git credential manager"
fi

if ! hash zoxide &> /dev/null ; then
    anyinstalled=true
    info "Installing zoxide"
    curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh || error "Failed to install zoxide"
fi

if ! hash code &> /dev/null; then
    anyinstalled=true
    info "Installing VSCode"
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg || error "Failed to download MS public key"
    sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/keyrings/microsoft-archive-keyring.gpg || error "Failed to install MS public key"
    sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/microsoft-archive-keyring.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list' || error "Failed to add MS public key to keyring"
    sudo apt-get update
    sudo apt-get install code || error "Failed to install VSCode"
fi

if ! fc-list | grep -q firacode; then
    anyinstalled=true
    info "Installing firacode font"
    sudo apt install fonts-firacode || error "Failed to install firacode"
fi

if ! dpkg -l brave-browser 2> /dev/null | grep ii -q; then
    anyinstalled=true
    sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg || error "Failed to download brave public key"
    sudo curl -fsSLo /etc/apt/sources.list.d/brave-browser-release.sources https://brave-browser-apt-release.s3.brave.com/brave-browser.sources || error "Failed to download brave package source"
    sudo apt update
    sudo apt install brave-browser || error "Failed to instal brave"
fi

if ! hash nvim &> /dev/null; then
    anyinstalled=true
    sudo apt-get install neovim || error "Failed to install neovim"
fi

if ! dpkg -l gnome-shell-extension-auto-move-windows 2> /dev/null | grep ii -q; then
    anyinstalled=true
    sudo apt install gnome-shell-extension-auto-move-windows
fi

if [ $anyinstalled = false ]; then
    success "All common packages already installed"
fi
