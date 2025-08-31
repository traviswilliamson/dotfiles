#! /usr/bin/bash

DIR=$(dirname "$0")
pushd "$DIR" > /dev/null

source $HOME/scripts/os.source
source $HOME/scripts/colors.source

_env=$1
_os=$(os)
info "\nInstalling common $_os packages\n"
bash "./$_os/common.sh"
info "\nInstalling $_env $_os packages\n"
bash "./$_os/$_env.sh"
success "\nFinished installing packages\n"

popd > /dev/null
