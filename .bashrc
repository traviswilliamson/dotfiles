# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# History
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend
PROMPT_COMMAND='history -a'

# Prompt
PS1=$'\[\e]0;\u@\h:\w\a\]\[\e[38;5;34m\]\u@\h\[\e[0m\]:\[\e[93m\]\w\[\e[38;5;39m\]\[\e[0m\]$(if $(git rev-parse --is-inside-work-tree 2> /dev/null ); then echo -e " \033[0;36m($(git branch --show-current))\033[0m"; fi)\n\xE2\x9E\xA4  '

case "$TERM" in
xterm*|rxvt*)
    # Set cursor to blinking bar
    echo -e -n "\x1b[\x35 q"
    ;;
*)
    ;;
esac

# Completions
# source $HOME/.git-completion.source

# Exports
export LESS="$LESS -R --no-init --quit-if-one-screen"
export NVM_DIR="$HOME/.nvm"
source ~/scripts/os.source
case $(os) in
("linux")
    export PATH="$PATH:~/local/bin"
    ;;
("macos"*)
    ;;
("windows")
    export PATH="/c/Program Files/Neovim/bin:$PATH"
    export PATH="/c/ProgramData/chocolatey/lib/Elixir/tools/bin:$PATH"
    ;;
esac

# Plugins
eval "$(zoxide init bash)"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Other scripts
source ~/scripts/sourceall.sh