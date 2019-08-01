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
Plugin 'jacoborus/tender.vim' " color scheme tender
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" General
set number	" Show line numbers
set linebreak	" Break lines at word (requires Wrap lines)
set showbreak=+++	" Wrap-broken line prefix
set textwidth=100	" Line wrap (number of cols)
set showmatch	" Highlight matching brace
set visualbell	" Use visual bell (no beeping)
 
set hlsearch	" Highlight all search results
set smartcase	" Enable smart-case search
set ignorecase	" Always case-insensitive
set incsearch	" Searches for strings incrementally
 
set autoindent	" Auto-indent new lines
set shiftwidth=2	" Number of auto-indent spaces
set smartindent	" Enable smart-indent
set smarttab	" Enable smart-tabs
set softtabstop=2	" Number of spaces per Tab

let mapleader = ","
 
" Advanced
set ruler	" Show row and column ruler information
 
set undolevels=1000	" Number of undo levels
set backspace=indent,eol,start	" Backspace behaviour

" NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <C-n> :NERDTreeToggle<CR>
 
" Color scheme tender
if (has("termguicolors"))
 set termguicolors
endif
syntax enable
colorscheme tender
" Set airline theme
let g:airline_theme = 'tender'

