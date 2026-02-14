#! /bin/bash

source $HOME/scripts/colors.source

info "Updating package list"
sudo apt update
anyinstalled=false

if ! hash curl &> /dev/null; then
    anyinstalled=true
    info "Installing curl"
    sudo apt install curl || logerror "Failed to install curl"
fi

if ! hash wget &> /dev/null; then
    anyinstalled=true
    info "Installing wget"
    sudo apt-get install wget || logerror "Failed to install wget"
fi

if ! hash dotnet &> /dev/null; then
    anyinstalled=true
    info "Installing dotnet"
    wget https://packages.microsoft.com/config/debian/12/packages-microsoft-prod.deb -O packages-microsoft-prod.deb || logerror "Failed to download MS deb file"
    sudo dpkg -i packages-microsoft-prod.deb || logerror "Failed to install MS deb file"
    rm packages-microsoft-prod.deb
    sudo apt-get update
    sudo apt-get install -y dotnet-sdk-9.0 && success "Installed .net 9 SDK" || logerror "Failed to install .net 9 SDK"
    sudo apt-get install -y aspnetcore-runtime-8.0 && successs "Installed ASP.Net 8 runtime" || logerror "Failed to install ASP.Net 8 runtime"
    dotnet dev-certs https --trust && success "Trusted .net dev cert" || logerror "Failed to trust .net dev-certs"
fi


if ! dotnet tool list -g git-credential-manager &> /dev/null; then
    anyinstalled=true
    info "Installing git-credential-manager"
    dotnet tool install -g git-credential-manager || logerror "Failed to install git credential manageR"
    git-credential-manager configure || logerror "Failed to configure git credential manager"
    sudo dotnet workload update || logerror "Failed to update git credential manager"
fi

if ! hash zoxide &> /dev/null ; then
    anyinstalled=true
    info "Installing zoxide"
    curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh || logerror "Failed to install zoxide"
fi

if ! hash code &> /dev/null; then
    anyinstalled=true
    info "Installing VSCode"
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg || logerror "Failed to download MS public key"
    sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/keyrings/microsoft-archive-keyring.gpg || logerror "Failed to install MS public key"
    sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/microsoft-archive-keyring.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list' || logerror "Failed to add MS public key to keyring"
    sudo apt-get update
    sudo apt-get install code || logerror "Failed to install VSCode"
fi

if ! fc-list | grep -q firacode; then
    anyinstalled=true
    info "Installing firacode font"
    sudo apt install fonts-firacode || logerror "Failed to install firacode"
fi

if ! dpkg -l brave-browser 2> /dev/null | grep ii -q; then
    anyinstalled=true
    info "Installing Brave"
    sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg || logerror "Failed to download brave public key"
    sudo curl -fsSLo /etc/apt/sources.list.d/brave-browser-release.sources https://brave-browser-apt-release.s3.brave.com/brave-browser.sources || logerror "Failed to download brave package source"
    sudo apt update
    sudo apt install brave-browser || logerror "Failed to install brave"
fi

if ! hash nvim &> /dev/null; then
    anyinstalled=true
    info "Installing Neovim"
    sudo apt-get install neovim || logerror "Failed to install neovim"
fi

if ! dpkg -l gnome-shell-extension-auto-move-windows 2> /dev/null | grep ii -q; then
    anyinstalled=true
    info "Installing gnome shell extension: auto-move windows"
    sudo apt install gnome-shell-extension-auto-move-windows
fi

if ! hash python3 &> /dev/null; then
    anyinstalled=true
    info "Installing python"
    sudo apt-get install python3 || logerror "Failed to install python"
fi

if ! hash pip3 &> /dev/null; then
    anyinstalled=true
    info "Installing pip"
    sudo apt-get install python3-pip || logerror "Failed to install pip"
fi

if ! hash jq &> /dev/null; then
    anyinstalled=true
    info "Installing jq"
    sudo apt-get install jq || logerror "Failed to install jq"
fi

# TODO: Elixir?

if [[ $anyinstalled == false ]]; then
    success "All common packages already installed"
fi
