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
set completeopt=menu,menuone,noselect
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
set showcmd                     " display incomplete commands
set shortmess+=A                " Don't bother me when a swapfile exists
set sidescrolloff=5             " Keep cursor away from this many chars left/right
set smartcase                   " Lets you search for ALL CAPS
set splitbelow                  " Open new split panes to bottom
set splitright                  " Open new split panes to right
set sessionoptions+=winpos,terminal,folds
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

" Always use vertical diffs
if &diff
  set diffopt+=vertical
endif
" }}}

" Keybindings {{{
" Set leader to <space>
let mapleader = ' '

" Faster window movement.
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-h> <C-W>h
nmap <C-l> <C-W>l

" Get off my lawn.
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Turn off linewise keys.
nmap j gj
nmap k gk

" Keep selection after indenting.
xnoremap < <gv
xnoremap > >gv

" Escape terminal mode
tnoremap <Esc> <C-\><C-n>

" Use \l to clear the highlighting of :set hlsearch.
if maparg('\l', 'n') ==# ''
  nnoremap <silent> \l :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR>\l
endif

" Use \c to trim spaces at EOL and retab.
if maparg('\c', 'n') ==# ''
  command! TEOL %s/\s\+$//
  command! CLEAN retab | TEOL
  nmap \c :CLEAN<CR>
endif

" Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fs <cmd>Telescope session-lens search_session<cr>

" Open Neovim config in vertical split
nnoremap <leader>ev :vsplit $MYVIMRC<cr>

" Source Neovim config
nnoremap <leader>sv :source $MYVIMRC<cr>
" }}}

" Autocmd {{{
augroup auto
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Set syntax highlighting for specific file types
  autocmd BufNewFile,BufRead *.md,*.mdx,*.markdown :set filetype=markdown
  autocmd BufNewFile,BufRead *.tpl :set filetype=html

  " Resize panes when window/terminal gets resize
  autocmd VimResized * :wincmd =
augroup END
" }}}

" Plugins {{{
call plug#begin('~/.local/share/nvim/plugged')

" Language Server
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'jose-elias-alvarez/null-ls.nvim'

" Completion
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

" Treesitter
" https://github.com/nvim-treesitter/nvim-treesitter/issues/1111
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Snippets
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

" Sessions
Plug 'rmagatti/auto-session'
Plug 'rmagatti/session-lens'

" File Management
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

" Status Line
Plug 'hoob3rt/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'

" Tabline
Plug 'alvarosevilla95/luatab.nvim'

" Git
Plug 'lewis6991/gitsigns.nvim'
Plug 'tpope/vim-fugitive'

" Comments
Plug 'JoosepAlviste/nvim-ts-context-commentstring'
Plug 'tpope/vim-commentary'

" Development
Plug 'mattn/emmet-vim'

" Utilities
Plug 'andymass/vim-matchup'
Plug 'onsails/lspkind-nvim'
Plug 'moll/vim-bbye'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'windwp/nvim-autopairs'

" Themes
Plug 'arcticicestudio/nord-vim'

" initialize plugin system
call plug#end()
" }}}

" Colors {{{
if (has('termguicolors'))
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

" Language Server Configuration {{{
lua << EOF
-- Setup lsp-installer.
local lsp_installer = require('nvim-lsp-installer')

lsp_installer.on_server_ready(function(server)
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  local opts = {
    on_attach = function(client, bufnr)
      if client.name == 'cssls' then
        client.resolved_capabilities.document_formatting = false
      end

      if client.name == 'tsserver' then
        client.resolved_capabilities.document_formatting = false
      end
    end,

    capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
  }

  server:setup(opts)
end)

-- Setup nvim-cmp.
local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end,
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
  }),
})

-- Use buffer source for `/`.
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':'.
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- Setup treesitter.
local treesitter = require'nvim-treesitter.configs'

treesitter.setup {
  -- One of "all", "maintained", or a list of languages
  ensure_installed = {
    'bash',
    'css',
    'fish',
    'html',
    'javascript',
    'jsdoc',
    'json',
    'scss',
    'tsx',
    'typescript',
    'vim',
    'vue'
  },
  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- list of language that will be disabled
    disable = {},

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled ().
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = true
  },
  indent = {
    enable = true
  },
  -- Enable JoosepAlviste/nvim-ts-context-commentstring
  context_commentstring = {
    enable = true
  },
  -- Enable andymass/vim-matchup/
  matchup = {
    enable = true
  },
}
EOF
" }}}

" Plug 'jose-elias-alvarez/null-ls.nvim' {{{
lua << EOF
local null_ls_status_ok, null_ls = pcall(require, 'null-ls')

if not null_ls_status_ok then
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup {
  debug = false,
  on_attach = function(client)
    if client.resolved_capabilities.document_formatting then
      vim.cmd([[
        augroup LspFormatting
          autocmd! * <buffer>
          autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
        augroup END
      ]])
    end
  end,
  sources = {
    formatting.eslint.with({
      prefer_local = "node_modules/.bin",
    }),
    formatting.stylelint.with({
      prefer_local = "node_modules/.bin",
    }),
    diagnostics.eslint.with({
      prefer_local = "node_modules/.bin",
    }),
    diagnostics.stylelint.with({
      prefer_local = "node_modules/.bin",
    }),
  },
}
EOF
" }}}

" Plug 'mattn/emmet-vim' {{{
" Redefine trigger key
let g:user_emmet_leader_key=','

" Enable just for html/css
let g:user_emmet_install_global = 0
autocmd FileType css,html,php,scss,vue EmmetInstall
" }}}

" Plug mhinz/neovim-remote {{{
" Use nvr as git editor
let $GIT_EDITOR = 'nvr -cc split --remote-wait'

" Prefer `:wq` or `:x` over of `:w|bd`
autocmd FileType gitcommit,gitrebase,gitconfig set bufhidden=delete
" }}}

" Plug rmagatti/auto-session {{{
lua << EOF
require('auto-session').setup{}
EOF
" }}}

" Plug rmagatti/session-lens {{{
lua << EOF
require('session-lens').setup{
  path_display = {'shorten'}
}
EOF
" }}}

" nvim-telescope/telescope.nvim {{{
lua << EOF
require('telescope').setup {
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ['<C-h>'] = 'which_key'
      }
    }
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = 'smart_case'
    }
  }
}
require('telescope').load_extension('fzf')
require('telescope').load_extension('session-lens')
EOF
" }}}

" Plug 'hoob3rt/lualine.nvim' {{{
lua << EOF
require('plenary.reload').reload_module('lualine', true)
require('lualine').setup({
  options = {
    theme = 'nord',
  },
  sections = {
    lualine_c = {
      require('auto-session-library').current_session_name
    },
    lualine_x = {},
    -- lualine_y = {},
    -- lualine_z = {},
  }
})
EOF
" }}}

" Plug 'lewis6991/gitsigns.nvim' {{{
lua << EOF
require('gitsigns').setup()
EOF
" }}}

" Plug 'onsails/lspkind-nvim' {{{
lua << EOF
require('lspkind').init({})
EOF
" }}}

" Plug 'windwp/nvim-autopairs' {{{
lua << EOF
require('nvim-autopairs').setup()
EOF
" }}}

" Plug 'norcalli/nvim-colorizer.lua' {{{
lua << EOF
require'colorizer'.setup()
require'colorizer'.setup {
  css = {
    css_fn = true;
  };
  html = {
    mode = 'foreground';
    names = false;
  };
  'javascript';
}
EOF
" }}}

" Plug 'alvarosevilla95/luatab.nvim' {{{
lua << EOF
require('luatab').setup({})
EOF
" }}}

" https://vi.stackexchange.com/questions/3814/is-there-a-best-practice-to-fold-a-vimrc-file
" vim: filetype=vim foldmethod=marker foldlevel=0 foldcolumn=3
