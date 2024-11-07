return {
  { "ellisonleao/gruvbox.nvim" },
  { "kyazdani42/nvim-web-devicons" },
  { "lukas-reineke/indent-blankline.nvim" },
  { "numToStr/Comment.nvim" },
  { "nvim-lualine/lualine.nvim" },
  { "nvim-tree/nvim-tree.lua" },
  { "nvim-treesitter/nvim-treesitter" },
  { "tree-sitter/tree-sitter-regex" },
  { "nvim-treesitter/nvim-treesitter-context" },
  {'neovim/nvim-lspconfig'},
  {'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
  {'williamboman/mason.nvim'},
  {'williamboman/mason-lspconfig.nvim'},
  {'WhoIsSethDaniel/mason-tool-installer.nvim'},
  {"mfussenegger/nvim-dap"},
  {"jay-babu/mason-nvim-dap.nvim"},
  {'hrsh7th/nvim-cmp'},
  {'hrsh7th/cmp-nvim-lsp'},
  {'github/copilot.vim'},
  {"stevearc/conform.nvim"},
  {"mfussenegger/nvim-lint"},
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" },
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    }
  },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.6',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  { "marko-cerovac/material.nvim" },
  {
    "robitx/gp.nvim",
    config = function()
      require("gp").setup()
    end,
  },
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end
  },
  {
    "RRethy/nvim-treesitter-endwise",
    config = function()
      require('nvim-treesitter.configs').setup {
        endwise = {
          enable = true,
        },
      }
    end

  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      'nvim-neotest/neotest-jest',
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter"
    }
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "sindrets/diffview.nvim",        -- optional - Diff integration

      -- Only one of these is needed.
      "nvim-telescope/telescope.nvim", -- optional
      "ibhagwan/fzf-lua",              -- optional
      "echasnovski/mini.pick",         -- optional
    },
    config = true
  },
}
