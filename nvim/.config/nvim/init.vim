" Plugin manager settings  -------------------------------------------------{{{
set nocompatible

call plug#begin()

Plug 'luisiacc/gruvbox-baby', {'branch': 'main'}
Plug 'nvim-lualine/lualine.nvim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'airblade/vim-rooter'
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
Plug 'hkupty/iron.nvim'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-telescope/telescope.nvim', {'branch': '0.1.x'}
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'onsails/lspkind-nvim'
Plug 'hrsh7th/cmp-path'
" Plug 'simrat39/rust-tools.nvim'

Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown', {'for': 'markdown'}
Plug 'rust-lang/rust.vim', {'for': 'rust'}
Plug 'cespare/vim-toml', {'for': 'toml'}
Plug 'stephpy/vim-yaml', {'for': 'yaml'}

call plug#end()
filetype plugin indent on    " required

" }}}

" Basic settings  ----------------------------------------------------------{{{

" syntax on                 " syntax highlighing
" filetype on               " try to detect filetypes
" filetype plugin indent on " enable loading indent file for filetype
set number                " Display line numbers
set relativenumber        " Display relative line numbers
" set background=dark       " We are using dark background in vim
set wildmenu              " Menu completion in command mode on <Tab>
set wildmode=full         " <Tab> cycles between all matching choices.
set t_Co=256              " Force terminal colors to 256
set enc=utf-8             " utf-8 encoding
set hlsearch              " highlight search results
set foldnestmax=1         " fold only one level by default
set updatetime=50         " Update delay for CursorHold events

""" Moving Around/Editing
set pastetoggle=<F3>      " paste mode to preserve indentation
set cursorline            " have a line indicate the cursor location
set ruler                 " show the cursor position all the time
set nostartofline         " Avoid moving cursor to BOL when jumping around
set virtualedit=block     " Let cursor move past the last char in <C-v> mode
set scrolloff=8           " Keep 8 context lines above and below the cursor
set backspace=2           " Allow backspacing over autoindent, EOL, and BOL
set showmatch             " Briefly jump to a paren once it's balanced
set nowrap                " Wrap text
set linebreak             " don't wrap textin the middle of a word
set autoindent            " always set autoindenting on
set cindent               " use smart indent if there is no indent file
set tabstop=2             " <tab> inserts 2 spaces
set shiftwidth=2          " but an indent level is 2 spaces wide.
set softtabstop=2         " <BS> over an autoindent deletes spaces.
set expandtab             " Use spaces, not tabs, for autoindent/tab key.
set shiftround            " rounds indent to a multiple of shiftwidth.
set colorcolumn=80        " Show colored column at 80 characters.
set splitbelow            " Vertical splits open below current editor.
set splitright            " Horizontal splits open to the right of the current editor.

""" Messages, Info, Status
set laststatus=2          " always show status line
set showcmd               " Show incomplete normal mode commands as I type.
set report=0              " : commands always print changed line count.
set shortmess+=a          " Use [+]/[RO]/[w] for modified/readonly/written.
set ruler                 " Show some info, even without statuslines.

""" Do not create swapfile/backup files
set nowritebackup
set nobackup
set noswapfile

" }}}

" Custom key maps  ---------------------------------------------------------{{{

let mapleader="\<Space>"
let maplocalleader=",,"

" jk to escape insert mode
inoremap jk <esc>
inoremap <esc> <nop>

" Paste from clipboard
noremap <leader>p "+p
noremap <leader>y "+y

" ctrl-hjkl navigates the splits
noremap <c-h> <c-w>h
noremap <c-j> <c-w>j
noremap <c-k> <c-w>k
noremap <c-l> <c-w>l

" ctrl-hjkl navigates the splits in terminal mode
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l
tnoremap <Esc> <C-\><C-n>

" Quit window on <leader>q
nnoremap <leader>q :q<CR>

" Disable ex mode
nnoremap Q <nop>

" keymap edit/source vimrc
nnoremap <leader>ev :split $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" remove trailing whitespace
nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" folds keymaps
nnoremap <silent> <F6> :set foldmethod=indent<CR>
nnoremap <silent> <F8> :setlocal foldnestmax=2<CR>

" }}}

" Color scheme  ------------------------------------------------------------{{{

set termguicolors
let g:gruvbox_baby_background_color="dark"
let g:gruvbox_baby_function_style="NONE"
let g:gruvbox_baby_keyword_style="NONE"
let g:gruvbox_baby_comment_style="NONE"
colorscheme gruvbox-baby

" }}}

" Autocommands  ------------------------------------------------------------{{{

" Enter terminal buffer in insert mode
augroup terminal_commands
  au!
  au BufEnter * if &buftype == 'terminal' | startinsert | endif
augroup END

" No line numbers in terminal buffer
au TermOpen * setlocal nonumber norelativenumber

" Fold vimrc on markers
augroup vimrc_comment_folding
  au!
  au FileType vim
    \   setlocal foldmethod=marker " vimrc folds
    \ | setlocal foldlevel=0
augroup END

" }}}

" Plugin configurations  ---------------------------------------------------{{{

lua require('ironconfig_cfg')
lua require('treesitter_cfg')
lua require('lsp_cfg')

" iron.nvim
noremap <leader>$ :IronRepl<CR>

" telescope
nnoremap <silent> ;f <cmd>Telescope find_files<cr>
nnoremap <silent> ;r <cmd>Telescope live_grep<cr>
nnoremap <silent> \\ <cmd>Telescope buffers<cr>
nnoremap <silent> ;; <cmd>Telescope help_tags<cr>

" }}}
