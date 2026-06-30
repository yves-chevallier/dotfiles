-- Plugin specification for lazy.nvim (migrated from packer.nvim)
return {
  -- Theme ---------------------------------------------------------------------
  {
    'navarasu/onedark.nvim',
    priority = 1000,
    config = function()
      require('onedark').setup { style = 'darker', transparent = true }
      require('onedark').load()
    end,
  },

  -- GitHub Copilot (single, consolidated stack: copilot.lua + cmp source) -----
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup {
        suggestion = { enabled = false }, -- handled through nvim-cmp
        panel = { enabled = false },
      }
    end,
  },
  {
    'zbirenbaum/copilot-cmp',
    dependencies = 'zbirenbaum/copilot.lua',
    config = function() require('copilot_cmp').setup() end,
  },

  -- File explorer -------------------------------------------------------------
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function() require('nvim-tree').setup {} end,
  },

  -- Integrated terminal -------------------------------------------------------
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
      require('toggleterm').setup { open_mapping = [[<leader>t]], direction = 'float' }
    end,
  },

  -- Status line ---------------------------------------------------------------
  {
    'nvim-lualine/lualine.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require('lualine').setup { options = { theme = 'onedark', icons_enabled = true } }
    end,
  },

  -- Symbols outline -----------------------------------------------------------
  {
    'simrat39/symbols-outline.nvim',
    config = function() require('symbols-outline').setup {} end,
  },

  -- Fuzzy finder --------------------------------------------------------------
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function() require('telescope').setup {} end,
  },

  -- Git signs -----------------------------------------------------------------
  {
    'lewis6991/gitsigns.nvim',
    config = function() require('gitsigns').setup {} end,
  },

  -- LSP -----------------------------------------------------------------------
  {
    'neovim/nvim-lspconfig',
    config = function() require('lspconfig').pyright.setup {} end,
  },

  -- Completion ----------------------------------------------------------------
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'zbirenbaum/copilot-cmp',
    },
    config = function()
      local cmp = require('cmp')
      cmp.setup {
        snippet = {
          expand = function(args) require('luasnip').lsp_expand(args.body) end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-y>'] = cmp.mapping.confirm({ select = true }),
          ['<C-Space>'] = cmp.mapping.complete(),
        }),
        sources = {
          { name = 'copilot' },
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'path' },
        },
      }
    end,
  },
}
