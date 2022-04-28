#!/bin/bash
#homebrew (includes xcode command line tools)
curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh

#zsh
brew install zsh
chsh -s /usr/local/bin/zsh # Set as default shell

#python
brew install python

#add python to path
echo 'path+="/usr/local/opt/python/libexec/bin"' >> ~/.zshrc
echo 'export PATH' >> ~/.zshrc

#pipenv
pip install --user pipenv

#git
brew install git

#git credential manager
brew tap microsoft/git
brew install --cask git-credential-manager-core

#zsh-syntax-highlighting

#zsh profile config

#sourcetree?

#chrome
brew install --cask google-chrome

#slack
brew install --cask slack

#discord?
brew install --cask discord

#vs code
brew install --cask visual-studio-code

#vscode extensions
code --install-extension ms-dotnettools.csharp --force
code --install-extension k--kato.docomment --force
code --install-extension visualstudioexptteam --force
code --install-extension 2gua.rainbow-brackets --force

#dotnet SDK
brew install --cask dotnet-sdk

#postman?

#ruby?

#ruby gems?

#node? -Maybe just for environment setup

#beyond compare?

#start backups?

#set a bunch of configs