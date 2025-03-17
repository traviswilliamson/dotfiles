### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/twilliamson/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
PROMPT_COMMAND='history -a'
alias daily="git add :; git commit -m \"Daily commit\"; git push"
alias killorig="find . -type f -name '*.orig' -delete"
alias ls="ls -a --color=auto"
export LESS="$LESS -R --no-init --quit-if-one-screen"
gohome() { gohome_temp_branch=$(git branch --show-current); git switch ${1-master}; git pull; git branch -D "${gohome_temp_branch}"; unset gohome_temp_branch; }
for b in $(find ~/scripts -name *.bash); do
    source $b
done
eval "$(zoxide init bash)"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion