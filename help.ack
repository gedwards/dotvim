# https://github.com/djanowski/ack-tutorial/
ack '\brequire\b' or ack -w require       # word boundary search
ack -l -w require                         # print filenames of files that contain the word 'require'
vim -p $(!! -l)                           # open in Vim the results of the last command
ack -Q '$.browser'                        # escape everything
ack -C 1 return                           # see the line before (A) and the line after (B) any line that has 'return'
