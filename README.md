# Dotfiles
This repo exists to keep track of configuration files so that setting up a new machine is both simple and consistent. Most devs have spent a lot of time getting their global environment set up to their liking and building common scripts; by preserving the configuration, that work isn't lost when switching computers. For simplicity, this repo is designed to live in your home directory.

## Gitignore
The magic of keeping this repo in your home directory is the `.gitignore`. Here it is: `*`. This way you can specifically add the dotfiles you find useful without dealing with symbolic links.

Exception: Some applications keep their settings outside of the user home directory. In that case, symlinking may be necessary. Example: VSCode (If you are not using the built-in sync).

## Setup
To bootstrap a new machine:
1. Make sure git and bash are on the machine
2. 
    ```bash
    cd ~
    git init
    git remote add origin https://github.com/traviswilliamson/dotfiles
    git fetch origin
    git checkout -t origin/main
    git switch main
    ```
7. Run `~/scripts/bootstrap.sh` with elevated permissions

### Packages
Packages in `scripts/packages/*.list` files will be installed using the filename as the package manager. So, for example, `choco.list` containing `vscode` will run `choco install vscode`. Specific exceptions to including `install` exist, defined in the `scripts/packages/install.sh` file, such as for VSCode extensions.

OS specific packages defined in `scripts/packages/$(os)/*.list` will only be installed on the given os.

### Repos
Repos defined in `scripts/repos/*.list` will be cloned into `~/repos/$1/` folders, designed for separate contexts like `personal` and `work`. Helpful repository managing scripts are available in `scripts/repos/repos.bash` making use of this folder structure.

### Scripts
All scripts specified in `scripts/sourceall.sh` will be sourced by `.bash_profile`

# Acknowledgements
- [Drew DeVault](https://drewdevault.com/2019/12/30/dotfiles.html)'s method of turning the home directory into a repo
- The [Windows boxstarter](https://github.com/microsoft/windows-dev-box-setup-scripts) example of good Windows configurations
- [Dotfiles](https://dotfiles.github.io/)'s collection of inspirations
- [Mathias Bynens](https://github.com/mathiasbynens/dotfiles)'s configuration options for macOS
- [Rosco Kalis](https://github.com/rkalis/dotfiles)'s bootstrap scripts

# General TODO
1. Clean up `.bashrc`
1. Linux packages
1. Merge all branches together
1. Make setting up the repo in ##setup a script run from curl
  1. [Make sure](https://askubuntu.com/a/409031) to `chmod +x` the other setup/install scripts. Maybe in `bootstrap.sh`?
1. OS specific configs

# .bashrc TODO

- Put aliases into file
- Improve PS1 prompt, something like git bash's default
  - Switch yellow and cyan for path/git
- Source scripts (At this point, for utils at next step)
- OS specific stuff
- Environment specific stuff, like rancher
- Set environment variables, like `$PATH`
- Now init plugins

# bootstrap TODO
- Ask for environment
- Make idempotent, check if package/repo installed/cloned
- Warning/error messages `command || warn "Failed to command"`
  - Build a list of these to show at the end of the script, like how compilers show errors
- Packages
    - OS
        - prereqs
        - common
        - environment
- repos
    - common & environment specific

# Packages on linux TODO
## curl
```bash
sudo apt install curl
```

## wget
```bash
sudo apt update
sudo apt-get install wget
```

## dotnet sdk
```bash
wget https://packages.microsoft.com/config/debian/12/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb
sudo apt-get update
sudo apt-get install -y dotnet-sdk-9.0
sudo apt-get install -y aspnetcore-runtime-8.0
```

## git credential manager
```bash
dotnet tool install -g git-credential-manager
git-credential-manager configure
dotnet dev-certs https --trust
sudo dotnet workload update
```

## zoxide
```bash
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
```

## vscode
```bash
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/keyrings/microsoft-archive-keyring.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/microsoft-archive-keyring.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt-get update
sudo apt-get install code
```

## firacode
```bash
sudo apt install fonts-firacode
```

## signal
```bash
wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg;
cat signal-desktop-keyring.gpg | sudo tee /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main' |\
  sudo tee /etc/apt/sources.list.d/signal-xenial.list
sudo apt update && sudo apt install signal-desktop
```

## brave
```bash
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
sudo curl -fsSLo /etc/apt/sources.list.d/brave-browser-release.sources https://brave-browser-apt-release.s3.brave.com/brave-browser.sources
sudo apt update
sudo apt install brave-browser
```

## neovim
```bash
sudo apt-get install neovim
```
