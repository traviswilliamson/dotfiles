PROMPT_COMMAND='history -a'
alias ls="ls -a --color=auto"
export LESS="$LESS -R --no-init --quit-if-one-screen"
source ~/scripts/sourceall.sh
export PATH="/c/Program Files/Neovim/bin:$PATH"
eval "$(zoxide init bash)"
export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion