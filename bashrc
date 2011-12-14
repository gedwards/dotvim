source cdargs-bash.sh
export PATH="$PATH:/usr/local/share/npm/bin"

export NODE_PATH="/usr/local/lib/node_modules"

#######################################################################################
#  color chart:
#  Black       0;30     Dark Gray     1;30      Blue        0;34     Light Blue    1;34
#  Red         0;31     Light Red     1;31      Purple      0;35     Light Purple  1;35
#  Green       0;32     Light Green   1;32      Cyan        0;36     Light Cyan    1;36
#  Brown       0;33     Yellow        1;33      Light Gray  0;37     White         1;37
#  No color    0

# \h:\W \u\$
# If id command returns zero, you’ve root access.
if [ $(id -u) -eq 0 ];
then # you are root, set red colour prompt
  PS1="\\[$(tput setaf 1)\\]\\u@\\h:\\w #\\[$(tput sgr0)\\]"
else # normal
  PS1="\[\e[0;32m\]\\W(\$(git branch 2>/dev/null | grep '^*' | colrm 1 2))\$\[\e[0m\] " #green
  #PS1="\\! \\W: "
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.


alias mtab='open -a MacVim'
alias be='bundle exec'
alias sql3p='sqlite3 -init db/startup.production.sql db/production.sqlite3'
alias sql3d='sqlite3 -init db/startup.development.sql db/development.sqlite3'
alias sql3t='sqlite3 -init db/startup.test.sql db/test.sqlite3'
alias beirb='be irb -r ./irb_load.rb'
