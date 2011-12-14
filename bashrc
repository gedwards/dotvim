source cdargs-bash.sh
alias sql3p='sqlite3 -init db/startup.production.sql db/production.sqlite3'
alias sql3d='sqlite3 -init db/startup.development.sql db/development.sqlite3'
alias sql3t='sqlite3 -init db/startup.test.sql db/test.sqlite3'
alias beirb='be irb -r ./irb_load.rb'
