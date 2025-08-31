#!/bin/bash

source $HOME/scripts/colors.source
source $HOME/scripts/repos/repos.source



_env=$1
if [[ ! "$_env" ]]; then
    error "Environment argument not passed in"
else
    info "Cloning repos"
    
    anycloned=false
    COMMENT=\#*
    repo_path=$(realpath ~/repos)
    if [[ ! -d "$repo_path/$_env" ]]; then
        mkdir -p "$repo_path/$_env" || error "Could not create repos folder"
    fi

    while read repo; do
        repo=${repo//$'\r'} #Strip off any carriage returns. Curse you Windows.
        if [[ $repo == $COMMENT ]]; then
            continue;
        elif ! repoexists "${repo##*/}" &> /dev/null; then
            anycloned=true
            pushd "$repo_path/$_env" > /dev/null
            info "Cloning ${repo##*/} into $_env"
            git clone $repo &
            popd > /dev/null
        fi
    done < "$(realpath "$(dirname "$0")")/$_env.list"

    wait

    if [[ $anycloned == true ]]; then
        success "All repos cloned\n"
    else
        success "No repos to clone\n"
    fi
fi
