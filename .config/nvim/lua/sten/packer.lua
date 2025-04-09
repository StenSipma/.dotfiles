-- For updating: source this file (:so %, or <leader>ps) and run :PackerSync.

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    -- Treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    }
    use 'nvim-treesitter/playground'
    use 'nvim-treesitter/nvim-treesitter-context'

    -- Convenience
    use 'mbbill/undotree'
    use 'terrortylor/nvim-comment'
    use 'declancm/maximize.nvim'
    use 'windwp/nvim-autopairs'

    -- Theme(s)
    use 'wittyjudge/gruvbox-material.nvim'

    -- Statusline
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    -- LSP (Language Server Protocols)
    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            {
                'williamboman/mason.nvim',
                run = ':MasonUpdate'
            },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Formatting & Linting
            -- { 'jose-elias-alvarez/null-ls.nvim' }, -- Outdated :(
            { 'stevearc/conform.nvim' }, -- Formatting
            -- Linting with: mfussenegger/nvim-lint

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },

            -- Specific LSP configs
            { 'simrat39/rust-tools.nvim' },
        }
    }

    -- LaTeX tools
    use 'lervag/vimtex'

    -- Jupyter Notebook
    -- use { 'dccsillag/magma-nvim', run = ':UpdateRemotePlugins' }
    -- use { 'luk400/vim-jukit' }
end)
