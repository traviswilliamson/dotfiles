#! /usr/bin/env sh

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
            git clone $repo &
            popd > /dev/null
        fi
    done < "$fn"
done

wait
