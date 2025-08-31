#! /usr/bin/bash

DIR=$(dirname "$0")
pushd "$DIR" > /dev/null

source $HOME/scripts/os.source
source $HOME/scripts/colors.source

_env=$1
_os=$(os)
info "Installing common $_os packages"
bash "./$_os/common.sh"
info "Installing $_env $_os packages"
bash "./$_os/$_env.sh"
success "Finished installing packages\n"

popd > /dev/null
