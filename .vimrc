set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim_elixir/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" Let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'easymotion/vim-easymotion'
Plugin 'scrooloose/nerdtree'
Plugin 'ctrlpvim/ctrlp.vim' " find files in console
Plugin 'airblade/vim-gitgutter' " git change highlighter
Plugin 'jacoborus/tender.vim' " color scheme tender
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'elixir-editors/vim-elixir'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"------------------------------------------------------------------------------
" General
"------------------------------------------------------------------------------

set number	        " Show line numbers
set linebreak	    " Break lines at word (requires Wrap lines)
set showbreak=+++	" Wrap-broken line prefix
set textwidth=500	" Line wrap (number of cols)
set showmatch	    " Highlight matching brace
set mat=2           " How many tenths of a second to blink when matching brackets
set showcmd         " Show (partial) commands (or size of selection in Visual mode) in the status line
set hid             " A buffer becomes hidden when it is abandoned
set foldcolumn=0    " Make sure that extra margin on left is removed

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500
 
set hlsearch	" Highlight all search results
set smartcase	" Enable smart-case search
set ignorecase	" Always case-insensitive
set incsearch	" Searches for strings incrementally
set infercase   " Allow smarter completion by infering the case
set lazyredraw  " Don't redraw while executing macros (good performance config)
set magic       " For regular expressions turn magic on

set nrformats=octal,hex,alpha " Enable Ctrl-A/Ctrl-X to work on octal and hex numbers, as well as characters

set expandtab     " Use spaces instead of tabs
set autoindent	  " Auto-indent new lines
set shiftwidth=2  " Number of auto-indent spaces
set tabstop=2
set shiftround    " Round indent to multiple of 'shiftwidth' for > and < commands
set smartindent	  " Enable smart-indent
set smarttab	  " Enable smart-tabs
set softtabstop=2 " Number of spaces per Tab

set ai            "Auto indent
set si            "Smart indent
set nowrap        "Don't Wrap lines (it is stupid)

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Fast saving
map <Leader>w :w<CR>
imap <Leader>w <ESC>:w<CR>
vmap <Leader>w <ESC><ESC>:w<CR>

" :W sudo saves the file
" (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null

" This is totally awesome - remap jj to escape in insert mode.  You'll never type jj anyway, so it's great!
inoremap jj <esc>l
nnoremap JJJJ <nop>

" Make sure that coursor is always vertically centered on j/k moves
set so=999
" add vertical lines on columns
set colorcolumn=80,120
" Sets how many lines of history VIM has to remember
set history=700
 
"------------------------------------------------------------------------------
" VIM user interface
"------------------------------------------------------------------------------

set ruler	" Show row and column ruler information
 
set undolevels=1000	" Number of undo levels

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif


" Turn on the WiLd menu
set wildmenu
" Set command-line completion mode
set wildmode=list:longest,full

" Highlight current line - allows you to track cursor position more easily
set cursorline

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
else
    set wildignore+=.git\*,.hg\*,.svn\*
endif


" NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <C-n> :NERDTreeToggle<CR>
 
"------------------------------------------------------------------------------
" Colors and Fonts
"------------------------------------------------------------------------------

if (has("termguicolors"))
 set termguicolors
endif
syntax enable
colorscheme tender
" Set airline theme
let g:airline_theme = 'tender'

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" highlight trailing space
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

"------------------------------------------------------------------------------
" Files, backups and undo
"------------------------------------------------------------------------------

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

" Remember things between sessions
"
" '20  - remember marks for 20 previous files
" \"50 - save 50 lines for each register
" :20  - remember 20 items in command-line history
" /20  - remember 20 items in search history
" %    - remember the buffer list (if vim started without a file arg)
" n    - set name of viminfo file
set viminfo='20,\"50,:20,/20,%,n~/.viminfo.go

" Define what to save with :mksession
" blank - empty windows
" buffers - all buffers not only ones in a window
" curdir - the current directory
" folds - including manually created ones
" help - the help window
" options - all options and mapping
" winsize - window sizes
" tabpages - all tab pages
set sessionoptions=blank,buffers,curdir,folds,help,options,winsize,tabpages

" Diff не сохраненных данных
command Unsaved execute "w !diff % -"

" Delete trailing white space on save, useful for Elixir ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.ex :call DeleteTrailingWS()
autocmd BufWrite *.exs :call DeleteTrailingWS()

"------------------------------------------------------------------------------
" Visual mode related
"------------------------------------------------------------------------------

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f', '')<CR>
vnoremap <silent> # :call VisualSelection('b', '')<CR>

"------------------------------------------------------------------------------
" Moving around, tabs, windows and buffers
"------------------------------------------------------------------------------

" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <c-space> ?

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer (w/o closing the current window)
map <leader>bd :Bclose<cr>

" Close all the buffers
map <leader>bda :1,1000 bd!<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>tj :tabnext
map <leader>tk :tabprevious

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()


" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%

"------------------------------------------------------------------------------
" Editing mappings
"------------------------------------------------------------------------------

" Remap VIM 0 to first non-blank character
map 0 ^

" Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

