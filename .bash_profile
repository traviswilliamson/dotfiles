### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/twilliamson/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
PROMPT_COMMAND='history -a'
alias daily="git add :; git commit -m \"Daily commit\"; git push"
alias killorig="find . -type f -name '*.orig' -delete"
alias ls="ls -a"
gohome() { gohome_temp_branch=$(git branch --show-current); git switch ${1-master}; git pull; git branch -D "${gohome_temp_branch}"; unset gohome_temp_branch; }
eval "$(zoxide init bash)"