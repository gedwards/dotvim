# set VI as the command line editor
# set -o vi

alias er='env | grep RAILS_ENV'
alias erd='export RAILS_ENV=development; echo $RAILS_ENV'
alias ert='export RAILS_ENV=test; echo $RAILS_ENV'

EDITOR=/usr/bin/vim; export EDITOR

export GIT_PS1_SHOWDIRTYSTATE=on
export GIT_PS1_SHOWUPSTREAM="git"
# export GIT_PS1_SHOWUPSTREAM="git verbose"
# export GIT_PS1_SHOWSTASHSTATE=on
# export GIT_PS1_SHOWUNTRACKEDFILES=on

[ -f /usr/local/etc/bash_completion.d/git-completion.bash ] && source /usr/local/etc/bash_completion.d/git-completion.bash

# Git prompt
[[ $- == *i* ]]   &&   . ~/.vim/git-prompt.sh

# export PATH="$PATH:/usr/local/share/npm/bin"
# export NODE_PATH="/usr/local/lib/node_modules"

#######################################################################################
#  color chart:
#  Black       0;30     Dark Gray     1;30      Blue        0;34     Light Blue    1;34
#  Red         0;31     Light Red     1;31      Purple      0;35     Light Purple  1;35
#  Green       0;32     Light Green   1;32      Cyan        0;36     Light Cyan    1;36
#  Brown       0;33     Yellow        1;33      Light Gray  0;37     White         1;37
#  No color    0

#PS1="\w\$ "
# \h:\W \u\$
# If id command returns zero, you’ve root access.
if [ $(id -u) -eq 0 ];
then # you are root, set red colour prompt
  PS1="\\[$(tput setaf 1)\\]\\u@\\h:\\w #\\[$(tput sgr0)\\]"
else # normal
  export PS1='\[\e[0;32m\]\W$(__git_ps1 "(%s)")\$\[\e[0m\] ' #green
  #PS1="\\! \\W: "
fi

alias ap='ansible-playbook'
alias mtab='open -a MacVim'
alias be='bundle exec'
alias k1='kill -9 %1'

if [ -f ~/.bashrc ]; then . ~/.bashrc ; fi
[ -f /usr/local/etc/bash_completion.d/cdargs-bash.sh ] && source /usr/local/etc/bash_completion.d/cdargs-bash.sh

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.
