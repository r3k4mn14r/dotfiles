return require("packer").startup(function()
    use 'wbthomason/packer.nvim'
    use 'nvim-lualine/lualine.nvim'
    use 'tpope/vim-surround'
    use 'tpope/vim-commentary'
    use 'airblade/vim-rooter'
    use 'tpope/vim-fugitive'
    use 'mhinz/vim-signify'
    use 'hkupty/iron.nvim'

    use 'tjdevries/colorbuddy.nvim'
    use 'tjdevries/gruvbuddy.nvim'

    use {
        'nvim-treesitter/nvim-treesitter',
        run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
    }
    use {'nvim-lua/popup.nvim',
         requires = { {'nvim-lua/plenary.nvim'} }
     } 
    use {'nvim-telescope/telescope.nvim', branch = '0.1.x',
         requires = { {'nvim-lua/plenary.nvim', 'nvim-telescope/telescope-fzy-native.nvim'} }
     } 
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/nvim-cmp'
    use 'onsails/lspkind-nvim'
    use 'hrsh7th/cmp-path'

    use {'rust-lang/rust.vim', ft = 'rust'}
    use {'cespare/vim-toml', ft = 'toml'}
    use {'stephpy/vim-yaml', ft = 'yaml'}
    use {'tomlion/vim-solidity', ft = 'solidity'}
end)
