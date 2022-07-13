" Plugin manager settings  -------------------------------------------------{{{
set nocompatible

call plug#begin()

Plug 'gruvbox-community/gruvbox'
Plug 'nvim-lualine/lualine.nvim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'airblade/vim-rooter'
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
Plug 'hkupty/iron.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'simrat39/rust-tools.nvim'
Plug 'ray-x/lsp_signature.nvim'
Plug 'nvim-telescope/telescope.nvim', {'tag': '0.1.0'}
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown', {'for': 'markdown'}
Plug 'rust-lang/rust.vim', {'for': 'rust'}
Plug 'cespare/vim-toml', {'for': 'toml'}
Plug 'stephpy/vim-yaml', {'for': 'yaml'}

call plug#end()
filetype plugin indent on    " required

" }}}

" Basic settings  ----------------------------------------------------------{{{
syntax on                 " syntax highlighing
filetype on               " try to detect filetypes
filetype plugin indent on " enable loading indent file for filetype
set number                " Display line numbers
set relativenumber        " Display relative line numbers
set background=dark       " We are using dark background in vim
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

" Color scheme -------------------------------------------------------------{{{

set termguicolors
let g:gruvbox_contrast_dark="hard"
let g:gruvbox_invert_selection='0'
colorscheme gruvbox

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

" Rust column width
au Filetype rust set colorcolumn=100

" }}}

" Plugin configurations  ---------------------------------------------------{{{
" iron.nvim
noremap <leader>! :IronPromptRepl<CR>
noremap <leader>$ :IronRepl<CR>
luafile $HOME/.config/nvim/ironconfig.lua

" }}}

" LSP configuration  -------------------------------------------------------{{{
set completeopt=noinsert,menuone,noselect
" setup lualine
lua << END
require('lualine').setup {
  options = {
    theme = 'gruvbox',
    separator = { left = '', right = ''}
  }
}
END

" Configure LSP through rust-tools.nvim plugin.
" rust-tools will configure and enable certain LSP features for us.
" See https://github.com/simrat39/rust-tools.nvim#configuration
lua << END
local nvim_lsp = require'lspconfig'
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true

local opts = {
    tools = { -- rust-tools options
        autoSetHints = true,
        hover_with_actions = true,
        inlay_hints = {
          only_current_line = true,
        },
    },

    -- all the opts to send to nvim-lspconfig
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    server = {
        settings = {
            ["rust-analyzer"] = {
                checkOnSave = {
                    command = "clippy"
                },
                cargo = {
                  allFeatures = true,
                },
                completion = {
                  postfix = {
                    enable = false,
                  },
                },
            }
        }
    },
}

-- Setup lspconfig.
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
end

require('rust-tools').setup(opts)  -- Setup rust-tools
require'lspconfig'.jedi_language_server.setup{}
END

" Setup Completion
" See https://github.com/hrsh7th/nvim-cmp#basic-configuration
lua <<END
local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({select = true})
  },

  -- Installed sources
  sources = {
    { name = 'buffer' },
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'path' },
  },
})
END

" Setup lsp_signature
lua <<END
local lsp_signature = require'lsp_signature'
lsp_signature.setup({
  bind = true,
  doc_lines = 0,
  hint_enable = false,
  handler_opts = {
    border = "none"
  }
})
END

" Setup nvim-treesitter
lua <<END
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "python", "rust" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  -- List of parsers to ignore installing (for "all")
  ignore_install = { "javascript" },

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = {},

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
END

" Setup telescope
lua <<END
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local previewers = require("telescope.previewers")
local action_state = require("telescope.actions.state")
local conf = require("telescope.config").values
local actions = require("telescope.actions")

require("telescope").setup({
	defaults = {
		file_sorter = require("telescope.sorters").get_fzy_sorter,
		prompt_prefix = " >",
		color_devicons = true,

		file_previewer = require("telescope.previewers").vim_buffer_cat.new,
		grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
		qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

		mappings = {
			i = {
				["<C-x>"] = false,
				["<C-q>"] = actions.send_to_qflist,
			},
		},
	},
	extensions = {
		fzy_native = {
			override_generic_sorter = false,
			override_file_sorter = true,
		},
	},
})
END

" }}}
