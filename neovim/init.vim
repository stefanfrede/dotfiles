"
"
" ██╗███╗   ██╗██╗████████╗██╗   ██╗██╗███╗   ███╗
" ██║████╗  ██║██║╚══██╔══╝██║   ██║██║████╗ ████║
" ██║██╔██╗ ██║██║   ██║   ██║   ██║██║██╔████╔██║
" ██║██║╚██╗██║██║   ██║   ╚██╗ ██╔╝██║██║╚██╔╝██║
" ██║██║ ╚████║██║   ██║██╗ ╚████╔╝ ██║██║ ╚═╝ ██║
" ╚═╝╚═╝  ╚═══╝╚═╝   ╚═╝╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝
"
"                @stefanfrede

" Settings {{{

" Customize indentation per file type
filetype plugin indent on

" Enable syntax highlighting
syntax enable

" Use :help 'option' to see the documentation for the given option

set autoread                    " Don't bother me when a file changes
set autowrite                   " Automatically :write before running commands
set backspace=indent,eol,start  " Backspace deletes like most programs in insert mode
set belloff=all                 " No flashing or beeping at all
set clipboard=unnamedplus       " Copy to system clipboard
set cmdheight=2                 " Better display for messages
set colorcolumn=+1              " Highlight current column
set complete-=i                 " Remove the i option from autocomplete
set cursorline                  " Highlight the current line
set display+=lastline           " Show as much as possible of the last line
set encoding=utf-8              " Set UTF-8 by default
set hidden                      " Don't prompt to save hidden windows until exit
set hlsearch                    " Hilight searching
set gdefault                    " Replace all matches on a line instead of just the first
set incsearch                   " Search as you type
set ignorecase                  " Case insensitive
set laststatus=2                " Always display the status line
set lazyredraw                  " Try to speed-up vim
set linebreak                   " Break long lines by word, not char
set list                        " Show whitespace as special chars - see next line
set listchars=tab:»\ ,trail:·,extends:>,precedes:<,nbsp:+
set matchtime=0                 " Speed up escape after (){} chars
set modelines=0                 " Disable modelines as a security precaution
set nrformats-=octal            " Set number format to octal
set nojoinspaces                " Use one space, not two, after punctuation
set noshowmode                  " Hide mode information -- INSERT --
set nomodeline                  " Disable modelines as a security precaution
set number                      " Enable line numbers
set numberwidth=5               " Set minimum number of columns for line numbers
set redrawtime=1000             " Stop highlighting if it takes more than a second
set relativenumber              " Enable relative line numbers
set ruler                       " Show row/col and percentage
set scrolloff=1                 " Keep cursor away from this many chars top/bottom
set sessionoptions-=options
set showcmd                     " display incomplete commands
set shortmess+=A                " Don't bother me when a swapfile exists
set sidescrolloff=5             " Keep cursor away from this many chars left/right
set smartcase                   " Lets you search for ALL CAPS
set splitbelow                  " Open new split panes to bottom
set splitright                  " Open new split panes to right
set synmaxcol=250               " Don't try to highlight lines longer than 250 characters
set textwidth=80                " Make it obvious where 80 characters are
set viewoptions-=options
set wildmenu                    " Show possible completions on command line
set wildmode=list:longest,full  " List all options and complete

" No backup
set nobackup
set noswapfile
set nowritebackup
set noundofile

" Softtabs, 2 spaces
set expandtab                   " No tabs"
set shiftround                  " Shift to certain columns, not just n spaces
set shiftwidth=2                " Number of spaces to shift for autoindent or >,<
set softtabstop=2               " Spaces 'feel' like tabs
set tabstop=2

" Folding
set foldlevel=20
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

" Turn off line numbers in terminal
autocmd TermOpen * setlocal nonumber norelativenumber
" }}}

" Keybindings {{{

" Set leader to <space>
let mapleader = ' '

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif
" }}}

" Plugins {{{
call plug#begin('~/.config/nvim/plugged')

" Themes
Plug 'arcticicestudio/nord-vim'

" initialize plugin system
call plug#end()
" }}}

" Colors {{{
if (has("termguicolors"))
  set termguicolors
endif

colorscheme nord

let g:nord_cursor_line_number_background = 1

let g:nord_italic = 1
let g:nord_italic_comments = 1

" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^Eterm'
  set t_Co=16
endif
" }}}

" https://vi.stackexchange.com/questions/3814/is-there-a-best-practice-to-fold-a-vimrc-file
" vim: filetype=vim foldmethod=marker foldlevel=0 foldcolumn=3
