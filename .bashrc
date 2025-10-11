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
source ~/scripts/gitstatus/gitstatus.prompt.sh
# Old terminals like Visual Studio don't render unicode \uXXXX UTF16 correctly, use the \xXX\xXX UTF8 notation
PS1=$'\[\e]0;\u@\h:\w\a\]\[\e[38;5;34m\]\u@\h\[\e[0m\]:\[\e[93m\]\w\[\e[38;5;39m\] ${GITSTATUS_PROMPT}\[\e[0m\]\n\xE2\x9E\xA4  '

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

# Color aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls -A --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi


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