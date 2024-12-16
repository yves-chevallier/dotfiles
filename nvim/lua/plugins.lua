return require('packer').startup(function(use)
    -- Packer peut gérer son propre update
    use 'wbthomason/packer.nvim'

    use {
        "github/copilot.vim",
        config = function()
            vim.g.copilot_no_tab_map = true -- Désactive le mapping automatique de Tab
            vim.api.nvim_set_keymap('i', '<C-l>', 'copilot#Accept("<CR>")', { silent = true, expr = true })
        end,
    }

    use {
        "zbirenbaum/copilot-cmp",
        requires = "zbirenbaum/copilot.lua",
        config = function()
            require("copilot").setup()
            require("copilot_cmp").setup()
        end,
    }


    -- Thèmes
    use {
        'navarasu/onedark.nvim',
        config = function()
            require('onedark').setup {
                style = 'darker', -- Utilise des couleurs proches de VSCode
                transparent = true, -- Conserve le fond actuel
            }
            require('onedark').load()
        end,
    }


    -- Explorateur de fichiers
    use {
        'nvim-tree/nvim-tree.lua',
        requires = 'nvim-tree/nvim-web-devicons',
        config = function()
            require('nvim-tree').setup {}
        end,
    }

    -- Terminal intégré
    use {
        "akinsho/toggleterm.nvim",
        tag = '*',
        config = function()
            require('toggleterm').setup {
                open_mapping = [[<leader>t]],
                direction = 'float', -- Ou 'horizontal' pour une apparence classique
            }
        end,
    }

    -- Barre d'état moderne
    use {
        'nvim-lualine/lualine.nvim',
        requires = 'nvim-tree/nvim-web-devicons',
        config = function()
            require('lualine').setup {
                options = {
                    theme = 'onedark',
                    icons_enabled = true,
                },
            }
        end,
    }

    -- Vue structurée des symboles
    use {
        'simrat39/symbols-outline.nvim',
        config = function()
            require('symbols-outline').setup {}
        end,
    }

    -- Moteur de recherche
    use {
        'nvim-telescope/telescope.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('telescope').setup {}
        end,
    }

    -- Gestion de Git
    use {
        'lewis6991/gitsigns.nvim',
        requires = 'nvim-lua/plenary.nvim',
        config = function()
            require('gitsigns').setup {}
        end,
    }

    -- Langage Server Protocol (LSP)
    use {
        'neovim/nvim-lspconfig',
        config = function()
            require('lspconfig').pyright.setup {}
        end,
    }

    -- Autocomplétion
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            'zbirdenbaum/copilot-cmp',
        },
        config = function()
            local cmp = require('cmp')
            cmp.setup {
                mapping = cmp.mapping.preset.insert({
                    ['<C-n>'] = cmp.mapping.select_next_item(),
                    ['<C-p>'] = cmp.mapping.select_prev_item(),
                    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                    ['<C-Space>'] = cmp.mapping.complete(),
                }),
                sources = {
                    { name = 'nvim_lsp' },
                    { name = 'buffer' },
                    { name = 'path' },
                },
            }
        end,
    }
end)
