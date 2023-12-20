local M = {
  {
    "nvim-lua/plenary.nvim",
  },
  -- lsp
  {
    "neovim/nvim-lspconfig",
    opts = function()
      return require("plugins.configs.lspconfig")
    end,
    config = function(_, opts)
      opts.setup()
    end
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      {
        "hrsh7th/cmp-path"
      },
      {
        "hrsh7th/cmp-buffer"
      },
      {
        "hrsh7th/cmp-cmdline"
      },
      {
        "saadparwaiz1/cmp_luasnip"
      },
      {
        "hrsh7th/cmp-nvim-lsp"
      },
      {
        "hrsh7th/cmp-nvim-lua"
      },
      {
        "onsails/lspkind.nvim"
      },
      {
        "L3MON4D3/LuaSnip",
        dependencies = "rafamadriz/friendly-snippets",
        opts = { history = true, updateevents = "TextChanged, TextchangedI" },
        config = function(_, opts)
          require("plugins.configs.luasnip").setup(opts)
        end
      }
    },
    opts = function()
      return require("plugins.configs.cmp")
    end,
    config = function(_, opts)
      require("cmp").setup(opts)
    end,
  },

  -- Complements
  {
    "dstein64/vim-startuptime",
    lazy = false
  },
  { 'RaafatTurki/hex.nvim',
    config = function (_, _)
      require("hex").setup()
    end,
    lazy = false
  },
  {
    "mbbill/undotree",
    config = function(_, _)
      vim.cmd [[
        let g:undotree_WindowLayout = 2
        let g:undotree_SetFocusWhenToggle = 1
      ]]
    end,
    lazy = false,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    run = ":TSUpdate",
    event = "BufRead",
    opts = function()
      return require("plugins.configs.nvim-treesitter")
    end,
    config = function(_, opts)
      local treesitter = require("nvim-treesitter.configs")
      treesitter.setup(opts)
    end
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter" },
      { "nvim-telescope/telescope-fzf-native.nvim" },
      { "piersolenski/telescope-import.nvim" },
    },
    cmd = "Telescope",
    opts = function()
      return require("plugins.configs.telescope")
    end,
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      for _, ext in ipairs(opts.extensions_list) do
        telescope.load_extension(ext)
      end
    end
  },
  {
    "nvim-tree/nvim-web-devicons",
    opts = function()
      return require("plugins.configs.nvim-web-devicons")
    end,
    config = function(_, opts)
      local default_icons = require("nvim-web-devicons").get_icons()
      local extend = vim.tbl_deep_extend("force", default_icons, opts)

      require("nvim-web-devicons").setup({ override = extend })
    end
  },
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    opts = function()
      return require("plugins.configs.nvim-tree")
    end,
    config = function(_, opts)
      require("nvim-tree").setup(opts)
    end,
    lazy = false
  },

  -- Themes
  {
    "loctvl842/monokai-pro.nvim"
  },
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = true,
  },
  {
    "sainnhe/sonokai"
  },
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    opts = {}
  },
}

return M
