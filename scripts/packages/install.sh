#! /usr/bin/env sh

DIR=$(dirname "$0")
cd "$DIR"

COMMENT=\#*

find * -name "*.list" | while read fn; do
    cmd="${fn%.*}"
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