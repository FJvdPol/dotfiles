######### # Aliases #########

# Git aliases (shorthands for git commands)
alias gi="git init"
alias gp="git push -u origin master"
alias gs="git status"
function gc(){
    git commit -m "$*"
}
function gca(){
    git add --all
    git commit -m "$*"
}

# Make directory and go in it
function mkcdir(){
    mkdir -p -- "$1" &&
      cd -P -- "$1"
}

# Show all items in current directory
alias la="ls -a"
