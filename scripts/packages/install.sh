#! /usr/bin/bash

DIR=$(dirname "$0")
cd "$DIR"

source $HOME/scripts/os.source
source $HOME/scripts/colors.source

COMMENT=\#*

# Bootstrap package managers by OS
case $(os) in
    "linux")
        ;;
    "macos"*)
        # xcode tools
        info "Installing XCode command line tools..."
        if xcode-select --print-path &>/dev/null; then
            success "XCode command line tools already installed."
        elif xcode-select --install &>/dev/null; then
            success "Finished installing XCode command line tools."
        else
            error "Failed to install XCode command line tools."
        fi

        # brew
        info "Installing brew"
        NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        ;;
    "windows")
        # choco
        winget install --id chocolatey.chocolatey --source winget
        choco upgrade chocolatey
        ;;
esac
# macos: Something for brew taps, must run before brew, currently need
# brew tap microsoft/git

# Common packages in this directory
# OS specific packages in child directory of that name
{ find * -maxdepth 0 -name "*.list"; find $(os) -name "*.list"; } | while read fn; do
    cmd="${fn%.*}"
    cmd="${cmd#*/}"
    while read package; do
        if [[ $package == $COMMENT ]];
        then continue
        fi
        info "$cmd $package"
        $cmd $package
    done < "$fn"
done
