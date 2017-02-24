#Add bash prompt here
export PS1="[\w] $:"

#Color Scheme for color coded directory listing
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad


#Add custom aliases here
alias ll='ls -l'
alias la='ls -al'
alias connectcims='ssh sk6829@access.cims.nyu.edu'
alias upadte_bash="source ~/.bash_profile"

#screen aliases
alias sl="screen -list"
alias sr="screen -resume"

#git aliases
alias gp="git push"
alias gs="git status"
alias gc="git commit"
alias gd="git diff"
