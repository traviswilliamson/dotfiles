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

The bootstrap script is intended to be idempotent, so it can be run multiple times as new pieces are added.

### Packages
Packages install scripts are defined in `scripts/packages/$(os)`, with environment specific packages defined in `work` and `home`, and common ones in `common`.

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
- A whole lot of StackOverflow posts

# General TODO
1. Merge all branches together
1. OS specific configs

# .bashrc TODO
- OS specific stuff
- Environment specific stuff, like rancher

# bootstrap TODO
- Build a list of errors to show at the end of the script, like how compilers show errors
