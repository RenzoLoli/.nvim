local mapper = require("core.utils").mapper

function g_opts()
  return {
    options = {
      mode = "buffers",
      offsets = {
        {
          filetype = "NvimTree",
          text = "Nvim Tree",
          separator = true,
          text_align = "left"
        }
      },
      indicator_icon = "▎",
      modified_icon = "●",
      left_trunc_marker = "",
      right_trunc_marker = "",
      numbers = "ordinal",
      max_name_length = 15,
      max_prefix_length = 6,
      diagnostics = "nvim_lsp",
      show_buffer_icons = true,
      show_buffer_close_icons = true,
      show_close_icon = false,
      persist_buffer_sort = true,
      enforce_regular_tabs = true,
      diagnostics_indicator = function(count, level)
        local icon = level:match("error") and "" or ""
        return icon .. count
      end,
    },
  }
end

function load_mappings()
  mapper("n", "<tab>", ":BufferLineCycleNext<CR>", { desc = "next buffer" })
  mapper("n", "<S-tab>", ":BufferLineCyclePrev<CR>", { desc = "prev buffer" })
  mapper("n", "<leader>x", function()
    require('bufdelete').bufdelete()
  end, { desc = "close buffer" })
end

return {
  'akinsho/bufferline.nvim',
  dependencies = {
    'famiu/bufdelete.nvim',
    'nvim-tree/nvim-web-devicons'
  },
  event = "BufRead",
  version = "*",
  opts = g_opts,
  config = function(_, opts)
    load_mappings()
    require("bufferline").setup(opts)
  end,
}
