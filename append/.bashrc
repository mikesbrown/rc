export EDITOR="$(which vim)"
export HISTCONTROL="ignoredups:erasedups"
export HISTFILESIZE=5000
shopt -s histappend

case "${OSTYPE}" in
    darwin*)
        alias ls='ls -F -G'
    ;;
    *)
        alias ls='ls -F --color=auto'
    ;;
esac

source ~/.git/git-completion.bash
source ~/.git/git-prompt.sh

export PS1='\h:$?:\w$(__git_ps1 " (%s)") \$ '
