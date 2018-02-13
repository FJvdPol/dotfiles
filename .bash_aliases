######### # Aliases #########  
alias folkert="echo 'Hello folkert'"
alias la="ls -a"
alias ptech="cd /mnt/d/CMD\ Amsterdam/Jaar\ 2/project_tech"
alias gp="git push"
alias gs="git status"
function gc(){ 
    git commit -m "$*" 
}
function mkcdir(){
    mkdir -p -- "$1" &&
      cd -P -- "$1"
}

