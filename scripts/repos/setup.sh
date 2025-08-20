#! /usr/bin/bash

source $HOME/scripts/colors.source

DIR=$(dirname "$0")
cd "$DIR"

COMMENT=\#*
REPO_PATH=$(realpath ~/repos)

mkdir $REPO_PATH

find * -name "*.list" | while read fn; do
    folder="${fn%.*}"
    mkdir -p "$REPO_PATH/$folder"
    while read repo; do
        if [[ $repo == $COMMENT ]];
        then continue; else
            pushd "$REPO_PATH/$folder" > /dev/null
            info "Cloning $repo into $folder"
            git clone $repo &
            popd > /dev/null
        fi
    done < "$fn"
done

wait
