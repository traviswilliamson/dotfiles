repo() {
    repo_base=$(realpath ~/repos)
    repo_path=$(find "$repo_base" -mindepth 2 -maxdepth 2 -type d -iname "*$1*" | head -n 1)
    if ! test "$1" || ! test "$repo_path"; then
        cd "$repo_base"
    else
        echo "found $repo_path"
        cd "$repo_path"
    fi
}
complete -W "$(find ~/repos -mindepth 2 -maxdepth 2 -type d -print0 | xargs -0 -n1 -- basename)" repo
forrepos() {
    CYAN='\033[0;36m'
    NC='\033[0m'
    for d in $(find ~/repos -mindepth 2 -maxdepth 2 ! -path . -type d); do
        pushd $d > /dev/null
        re=$(basename $d)
        echo -e "$CYAN$re$NC"
        eval "$@"
        popd > /dev/null
    done
}