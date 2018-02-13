######### # Aliases #########
# Random alias
alias folkert="echo 'Hello folkert'"

# Show all items in current directory
alias la="ls -a"

# Navigation aliases
alias nav_tech="cd /mnt/d/CMD\ Amsterdam/Jaar\ 2/project_tech"
alias nav_jaar2="cd /mnt/d/CMD\ Amsterdam/Jaar\ 2"

# Git aliases
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
