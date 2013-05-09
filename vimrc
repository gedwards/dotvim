syntax on
set nocompatible

" --- vundle begin ---
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" original repos on github
Bundle 'pangloss/vim-javascript.git'
Bundle 'scrooloose/nerdtree.git'
Bundle 'ddollar/nerdcommenter.git'
Bundle 'scrooloose/syntastic.git'
Bundle 'cakebaker/scss-syntax.vim.git'
Bundle 'tpope/vim-fugitive'
Bundle 'maxmeyer/vim-taskjuggler'
" Bundle 'Lokaltog/powerline'
Bundle 'mkitt/browser-refresh.vim'
Bundle 'gmarik/ide-popup.vim'
Bundle 'gmarik/github-search.vim'
Bundle 'AndrewRadev/splitjoin.vim'
Bundle 'avakhov/vim-yaml'
Bundle 'mileszs/ack.vim'
Bundle 'rking/ag.vim'
" Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}

" vim-scripts repos
Bundle 'VOoM'
Bundle 'surround.vim'

" Bundle 'Vitality'
Bundle 'bufexplorer.zip'
Bundle 'gitv'
Bundle 'Gundo'
Bundle 'Handlebars'
Bundle 'EasyMotion'
Bundle 'ZoomWin'
Bundle 'surround.vim'
Bundle 'repeat.vim'
Bundle 'jQuery'

" non github repos
Bundle 'git://git.wincent.com/command-t.git'

filetype plugin indent on

" --- vundle end -----

" --- SETTINGS for vundle installs begin -----
let g:RefreshRunningBrowserDefault = 'chrome'
map <silent><leader>r :RRB<CR>
imap \r <Esc>:RRB<CR>i

" --- SETTINGS for vundle installs end -----

set number
set ruler
syntax on

" Set encoding
set encoding=utf-8

" --- begin Greg improvements ----------
set mouse=a

" copy quicklist entries into args # http://blog.siyelo.com/vim-tips-part-ii
command! -nargs=0 -bar Qargs execute 'args' QuickfixFilenames()
" populate the argument list with each of the files named in the quickfix list
function! QuickfixFilenames()
  let buffer_numbers = {}
  for quickfix_item in getqflist()
    let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
  endfor
  return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
endfunction

" in Terminal on the Mac, change insert mode cursor to a pipe
if &term =~ "xterm"
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" tmux will only forward escape sequences to the terminal if surrounded by a
" DCS sequence
" "
" http://sourceforge.net/mailarchive/forum.php?thread_name=AANLkTinkbdoZ8eNR1X2UobLTeww1jFrvfJxTMfKSq-L%2B%40mail.gmail.com&forum_name=tmux-users
"
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"

  " Cmd-T tweaks
  " as of March 2013, with current iTerm (1.0.0.20130319), tmux (1.8)
  "   " and Vim (7.3, with patches 1-843), this is all I need:
  let g:CommandTCancelMap     = ['<ESC>', '<C-c>']
  "
  "       " when I originally started using Command-T inside a terminal,
  "         " I used to need these as well:
  let g:CommandTSelectNextMap = ['<C-j>', '<ESC>OB']
  let g:CommandTSelectPrevMap = ['<C-k>', '<ESC>OA']
endif

nnoremap <F5> :GundoToggle<CR> " http://sjl.bitbucket.org/gundo.vim/

" Search and Replace in Multiple Files
" example:
" :vimgrep /CurrencyNumberHelper/ app/models/*.rb
" :Qargs
" :argdo %s/CurrencyNumberHelper/CurrencyHelper/g
" :argdo update

command! -nargs=0 -bar Qargs execute 'args' QuickfixFilenames()

" populate the argument list with each of the files named in the quickfix list
function! QuickfixFilenames()
  let buffer_numbers = {}
  for quickfix_item in getqflist()
    let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
  endfor
  return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
endfunction
" end of Search and Replace in Multiple Files


" jump to first word-letter within the first column
" ?\%1c\w
" jump to first word-letter within the cursor column
:map <Leader>parent :exe '?\%' . col(".") . 'c\w'

" highlight (partial) word under cursor without moving
:map <Leader>8 :let @/ = '\<'.expand('<cword>').'\>'\|set hlsearch<C-M>
:map <Leader>g8 :let @/ = expand('<cword>')\|set hlsearch<C-M>

" make it easier to type ':' commands without requiring the shift-key
noremap ;; ;
map ; :

" edit command-line
map q; q:
" word completion
imap jj <C-n>
" show file list, even in Insert mode
imap \t <Esc><Leader>t

" text snippets
inoremap bbb '-'*30
inoremap xxx [x]
inoremap lll console.log();<C-o>F)
inoremap efff <Esc>bieffort <Esc>Ypibetter:<Esc>piworse:<Esc>piexpected:<Esc>kk^f l
inoremap tsk <Esc>yyp:s/^  *//e<CR>:s/  *$//e<CR>:s/[^-_ a-zA-Z0-9]//ge<CR>:s/ /_/ge<CR>Vu==itask <Esc>kddpkA "<Esc>JxA" {<CR>}<Esc>:noh<CR>ko
inoremap comppp complete: <Esc>:r ! ruby -e "require 'date'; print Date.today.to_s"<CR>kJ$a

" refactoring
vmap <Leader>extract "ty<Esc>`<j0V`>dh\parent<CR>%o<CR>def<Esc>"tpkJ`]Oend<Esc>v%=:nohlsearch<CR>
" vmap <Leader>extract "ty<Esc>`<j0V`>d<Leader>^[h\parent^M%o^Mdef^["tpkJ`]Oend^[v%==q

" make Ack easier to access
nnoremap <Leader>a :Ag
" ack for current selection
vmap <Leader>a "sy:Ag! "<C-R>""

" ZoomWin
nnoremap <Leader>z :ZoomWin<cr>

" keep searches away from the edge
set scrolloff=1

" easier window navigation
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" close the window to the left of this one
noremap <silent> <Leader>ch :wincmd h<cr>:close<cr>
noremap <silent> <Leader>cl :wincmd l<cr>:close<cr>
noremap <silent> <Leader>ck :wincmd k<cr>:close<cr>
noremap <silent> <Leader>cj :wincmd j<cr>:close<cr>

" shortcut for Gdiff
" nnoremap :gd :Gdiff
" shortcut for duffupdate
nnoremap :du :diffupdate

" faster search and replaces
:nnoremap <Leader>s :%s///cg<Left><Left><Left><Left>
:nnoremap <Leader>ss :.,$s///cg<Left><Left><Left><Left>
:nnoremap <Leader>S :%s/\<<C-r><C-w>\>//g<Left><Left>
:nnoremap <Leader>SS :.,$s/\<<C-r><C-w>\>//g<Left><Left>
:vmap <Leader>s "sy:%s/<C-R>=substitute(@s,"\n",'\\n','g')<CR>/
:vmap <Leader>S "sy:.,$s/<C-R>=substitute(@s,"\n",'\\n','g')<CR>/

" vmap <Leader>r "sy:%s/<C-R>"s/
" [I shows all instances of the word under the cursor in the document
" ]I shows all instances of the word under the cursor after your current location

"Ever notice a slight lag after typing the leader key + command? This lowers
"the timeout.
set timeoutlen=500

"Prefer relative line numbering?
"set relativenumber"

"Enable code folding
set foldenable

"Shortcut to fold tags with leader (usually \) + ft
nnoremap <leader>ft Vatzf

" More useful command-line completion
" set wildmenu

"Auto-completion menu
" set wildmode=list:longest

"Bubble single lines (kicks butt)
"http://vimcasts.org/episodes/bubbling-text/
" nmap <C-Up> ddkP
" nmap <C-Down> ddp

"Bubble multiple lines
" vmap <C-Up> xkP`[V`]
" vmap <C-Down> xp`[V`]

" print empty <a> tag
" map! ;h <a href=""></a><ESC>5hi

" --- end Greg improvements ------------

" Whitespace stuff
set nowrap
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set list listchars=tab:\ \ ,trail:·

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Tab completion
" set wildmode=list:longest,list:full
set wildignore+=*.png,*.jpg,*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*,.bundle,bundle

" Status bar
set laststatus=2

" NERDTree configuration
" let NERDTreeIgnore=['\.pyc$', '\.rbc$', '\~$']
" map <Leader>n :NERDTreeToggle<CR>
" map <Leader>nn :NERDTreeFind<CR>

" Command-T configuration
let g:CommandTMaxHeight=20

" CTags
map <Leader>rt :!ctags --extra=+f -R *<CR><CR>
map <C-\> :tnext<CR>

" Remember last location in file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

function! s:setupWrapping()
  :set wrap
  :set linebreak
  :set nolist
  :set textwidth=0
  :set wrapmargin=0
endfunction

function! s:setupMarkup()
  call s:setupWrapping()
  map <buffer> <Leader>p :Hammer<CR>
endfunction

" make uses real tabs
au FileType make set noexpandtab

" Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru}    set ft=ruby

" md, markdown, and mk are markdown and define buffer-local preview
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} call s:setupMarkup()

" add json syntax highlighting
au BufNewFile,BufRead *.json set ft=javascript

au BufRead,BufNewFile *.txt call s:setupWrapping()
autocmd BufEnter *.txt set spell
" autocmd FileType txt source ~/.vim/txt.vim

" add scss syntax highlighting
au BufRead,BufNewFile *.scss set filetype=scss

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" load the plugin and indent settings for the detected filetype
filetype plugin indent on

" Opens an edit command with the path of the currently edited file filled in
" Normal mode: <Leader>e
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Opens a tab edit command with the path of the currently edited file filled in
" Normal mode: <Leader>t
map <Leader>et :tabe <C-R>=expand("%:p:h") . "/" <CR>

" Inserts the path of the currently edited file into a command
" Command mode: Ctrl+P
cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

" Unimpaired configuration
" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

" Enable syntastic syntax checking
let g:syntastic_enable_signs=1
let g:syntastic_quiet_warnings=1

" Use modeline overrides
set modeline
set modelines=10

" Default color scheme
color desert

" Directories for swp files
set backupdir=~/.vim/backup
set directory=~/.vim/backup

" Turn off jslint errors by default
let g:JSLintHighlightErrorLine = 0

" MacVIM shift+arrow-keys behavior (required in .vimrc)
let macvim_hig_shift_movement = 1

" % to bounce from do to end etc.
runtime! macros/matchit.vim

" Show (partial) command in the status line
set showcmd

" Include user's local vim config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

function! ParagraphMove(delta, visual, count)
    normal m'
    normal |
    if a:visual
        normal gv
    endif

    if a:count == 0
        let limit = 1
    else
        let limit = a:count
    endif

    let i = 0
    while i < limit
        if a:delta > 0
            " first whitespace-only line following a non-whitespace character
            let pos1 = search("\\S", "W")
            let pos2 = search("^\\s*$", "W")
            if pos1 == 0 || pos2 == 0
                let pos = search("\\%$", "W")
            endif
        elseif a:delta < 0
            " first whitespace-only line preceding a non-whitespace character
            let pos1 = search("\\S", "bW")
            let pos2 = search("^\\s*$", "bW")
            if pos1 == 0 || pos2 == 0
                let pos = search("\\%^", "bW")
            endif
        endif
        let i += 1
    endwhile
    normal |
endfunction

nnoremap <silent> } :<C-U>call ParagraphMove( 1, 0, v:count)<CR>
onoremap <silent> } :<C-U>call ParagraphMove( 1, 0, v:count)<CR>
" vnoremap <silent> } :<C-U>call ParagraphMove( 1, 1)<CR>
nnoremap <silent> { :<C-U>call ParagraphMove(-1, 0, v:count)<CR>
onoremap <silent> { :<C-U>call ParagraphMove(-1, 0, v:count)<CR>
" vnoremap <silent> { :<C-U>call ParagraphMove(-1, 1)<CR>


