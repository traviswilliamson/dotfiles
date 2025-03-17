#! /usr/bin/env sh

DIR=$(dirname "$0")
cd "$DIR"

source ~/scripts/os.source

COMMENT=\#*

# TODO: Bootstrap package managers by OS
# Windows: choco
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
        if [[ $cmd == code* ]]; then
            echo "$cmd $package"
            $cmd $package
        else
            echo "$cmd install $package"
            $cmd install $package
        fi
    done < "$fn"
done