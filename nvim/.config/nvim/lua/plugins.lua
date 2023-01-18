return require("packer").startup(function()
    use 'wbthomason/packer.nvim'
    use { -- LSP configurations
        'neovim/nvim-lspconfig',
        requires = { 'williamboman/mason.nvim', 'williamboman/mason-lspconfig.nvim' },
    }
    use { -- Autocompletion
        'hrsh7th/nvim-cmp',
        requires = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip' },
    }
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
    }


    use {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
         requires = { 'nvim-lua/plenary.nvim' },
    } 
    use {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make',
        cond = vim.fn.executable 'make' == 1,
    }

    use 'tpope/vim-fugitive'
    use 'tpope/vim-surround'
    use 'numToStr/Comment.nvim'
    use 'hkupty/iron.nvim'

    use 'lewis6991/gitsigns.nvim'
    use 'nvim-lualine/lualine.nvim'
    use 'tjdevries/colorbuddy.nvim'
    use 'tjdevries/gruvbuddy.nvim'
    use 'norcalli/nvim-colorizer.lua'
    use 'onsails/lspkind-nvim'

    use {'rust-lang/rust.vim', ft = 'rust'}
    use {'cespare/vim-toml', ft = 'toml'}
    use {'stephpy/vim-yaml', ft = 'yaml'}
    use {'tomlion/vim-solidity', ft = 'solidity'}
end)
