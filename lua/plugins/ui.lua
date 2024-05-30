return {
  -- buffer line
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    enabled = false,
    keys = {
      { "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
      { "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
    },
    opts = {
      options = {
        mode = "tabs",
        -- separator_style = "slant",
        show_buffer_close_icons = false,
        show_close_icon = false,
      },
    },
  },

  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        -- globalstatus = false,
        theme = "auto",
      },
    },
  },

  -- filename
  {
    "b0o/incline.nvim",
    event = "BufReadPre",
    priority = 1200,
    config = function()
      local colors = require("kanagawa.colors").setup({ theme = "dragon" })
      require("incline").setup({
        highlight = {
          groups = {
            InclineNormal = { guibg = colors.palette.sumiInk0, guifg = colors.palette.dragonRed },
            InclineNormalNC = { guifg = colors.palette.sumiInk0, guibg = colors.palette.dragonRed },
          },
        },
        window = { margin = { vertical = 0, horizontal = 1 } },
        hide = {
          cursorline = true,
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          if vim.bo[props.buf].modified then
            filename = "[+] " .. filename
          end

          local icon, color = require("nvim-web-devicons").get_icon_color(filename)
          return { { icon, guifg = color }, { " " }, { filename } }
        end,
      })
    end,
  },

  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      window = {
        width = 0.8,
      },
      plugins = {
        options = {
          enabled = true,
          ruler = false,
          showcmd = false,
          laststatus = 0,
        },
        gitsigns = true,
        tmux = true,
        kitty = { enabled = true, font = "+2" },
        twilight = { enabled = true, font = "+2" },
      },
    },
    keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
  },

  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = function(_, opts)
      local logo = [[
                      ░░░░░░      ░░░░░░                      
                    ░░░░░░░░░░  ░░░░░░░░░░                    
                  ░░░░░░░░░░░░░░░░░░░░░░░░░░                  
                ░░░░░░░░░░▒▒▒▒░░▒▒▒▒░░░░░░░░░░                
              ░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░              
  ▒▒        ░░░░░░▒▒▒▒▒▒▒▒▒▒██▒▒██▒▒▒▒▒▒▒▒▒▒░░░░░░        ▒▒  
▒▒░░    ░░░░░░░░▒▒▒▒▒▒▒▒▒▒████▒▒████▒▒▒▒▒▒▒▒▒▒░░░░░░░░    ░░▒▒
▒▒▒▒░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒██████▒▒██████▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░▒▒▒▒
██▒▒▒▒▒▒▒▒▒▒▒▒▒▒██▒▒▒▒██████▓▓██▒▒██████▒▒▓▓██▒▒▒▒▒▒▒▒▒▒▒▒▒▒██
  ████▒▒▒▒▒▒████▒▒▒▒██████████  ██████████▒▒▒▒████▒▒▒▒▒▒▒▒██  
    ████████████████████████      ████████████████████████    
      ██████████████████              ██████████████████      
          ██████████                      ██████████          
]]
      logo = string.rep("\n", 8) .. logo .. "\n\n"
      opts.config.header = vim.split(logo, "\n")
    end,
  },
}
