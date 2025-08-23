# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

#TODO: Move to new file
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend
PROMPT_COMMAND='history -a'

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Prompt
source $HOME/.gitprompt.source
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUPSTREAM=verbose
GIT_PS1_SHOWCONFLICTSTATE=yes
PROMPT_COMMAND='PS1_CMD1=$(__git_ps1 " (%s)")'; PS1=$'\[\e]0;\u@\h:\w\a\]\[\e[38;5;34m\]\u@\h\[\e[0m\]:\[\e[93m\]\w\[\e[38;5;39m\]${PS1_CMD1}\[\e[0m\] \u27A4 '

case "$TERM" in
xterm*|rxvt*)
    # Set cursor to blinking bar
    echo -e -n "\x1b[\x35 q"
    ;;
*)
    ;;
esac

source $HOME/.git-completion.source

#TODO: Move to new file
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls -A --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi


#TODO: Move exports to new file
export LESS="$LESS -R --no-init --quit-if-one-screen"
source ~/scripts/sourceall.sh
export PATH="/c/Program Files/Neovim/bin:$PATH"
export PATH="$PATH:~/local/bin"

#TODO: Make OS specific: https://github.com/git-ecosystem/git-credential-manager/blob/release/docs/credstores.md
# macos=keychain
# windows=wincredman
export GCM_CREDENTIAL_STORE=secretservice

eval "$(zoxide init bash)"
export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
