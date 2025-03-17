# Dotfiles
This repo exists to keep track of configuration files so that setting up a new machine is both simple and consistent. Most devs have spent a lot of time getting their global environment set up to their liking and building common scripts; by preserving the configuration, that work isn't lost when switching computers. For simplicity, this repo is designed to live in your home directory.

## Gitignore
The magic of keeping this repo in your home directory is the `.gitignore`. Here it is: `*`. This way you can specifically add the dotfiles you find useful without dealing with symbolic links.

Exception: Some applications keep their settings outside of the user home directory. In that case, symlinking may be necessary. Example: VSCode (If you are not using the built-in sync).

## Setup
To bootstrap a new machine:
1. `git clone` this repo into your `~` directory.
2. Make sure bash is on the machine
3. Run `~/scripts/bootstrap.sh` with elevated permissions

### Packages
Packages in `scripts/packages/*.list` files will be installed using the filename as the package manager. So, for example, `choco.list` containing `vscode` will run `choco install vscode`. Specific exceptions to including `install` exist, defined in the `scripts/packages/install.sh` file, such as for VSCode extensions.

OS specific packages defined in `scripts/packages/$(os)/*.list` will only be installed on the given os.

### Repos
Repos defined in `scripts/repos/*.list` will be cloned into `~/repos/$1/` folders, designed for separate contexts like `personal` and `work`. Helpful repository managing scripts are available in `scripts/repos/repos.bash` making use of this folder structure.

### Scripts
All scripts matching `scripts/*.source` will be sourced by `.bash_profile`

## Branching
Work and personal machines may want diverging environments. To this end, the scripts and common packages are kept on `main`, and specific packages and configrations live on `home` and `work`. Merge changes from `main` into other branches, and cherry-pick from others into `main` if there are changes to common elements.

# Acknowledgements
- [Drew DeVault](https://drewdevault.com/2019/12/30/dotfiles.html)'s method of turning the home directory into a repo
- The [Windows boxstarter](https://github.com/microsoft/windows-dev-box-setup-scripts) example of good Windows configurations
- [Dotfiles](https://dotfiles.github.io/)'s collection of inspirations
- [Mathias Bynens](https://github.com/mathiasbynens/dotfiles)'s configuration options for macOS
- [Rosco Kalis](https://github.com/rkalis/dotfiles)'s bootstrap scripts

# TODO
1. Something with credential management to make it easier to work on `main` with the environment specific credential management.
1. OS specific `sudo`
1. OS specific bootstrap (Install package managers)
1. OS specific configs
