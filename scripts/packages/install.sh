#! /usr/bin/env sh

DIR=$(dirname "$0")
cd "$DIR"

source ~/scripts/os.source

COMMENT=\#*

# Bootstrap package managers by OS
case $(os) in
    "linux")
        ;;
    "macos"*)
        # brew
        NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        ;;
    "windows")
        # choco
        winget install --id chocolatey.chocolatey --source winget
        choco upgrade chocolatey
        ;;
esac
# macos: brew
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
        echo "$cmd $package"
        $cmd $package
    done < "$fn"
done