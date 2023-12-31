function g_opt()
  return {
    defaults = {
      vimgrep_arguments = {
        "rg",
        "-L",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
      },
      prompt_prefix = "   ",
      selection_caret = "> ",
      entry_prefix = "  ",
      initial_mode = "insert",
      selection_strategy = "reset",
      sorting_strategy = "ascending",
      layout_strategy = "horizontal",
      layout_config = {
        horizontal = {
          prompt_position = "top",
          preview_width = 0.55,
          results_width = 0.8,
        },
        vertical = {
          mirror = false,
        },
        width = 0.87,
        height = 0.80,
        preview_cutoff = 120,
      },
      file_sorter = require("telescope.sorters").get_fuzzy_file,
      file_ignore_patterns = { "node_modules" },
      generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
      path_display = { "truncate" },
      winblend = 0,
      border = {},
      borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      color_devicons = true,
      set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
      file_previewer = require("telescope.previewers").vim_buffer_cat.new,
      grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
      qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
      -- Developer configurations: Not meant for general override
      buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
      mappings = {
        n = { ["q"] = require("telescope.actions").close },
      },
    },

    extensions_list = {
      "import"
    },
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
      import = {
        -- Add imports to the top of the file keeping the cursor in place
        insert_at_top = false,
        -- Support additional languages
        custom_languages = {
          {
            -- The regex pattern for the import statement
            regex = [[^(?:import(?:[\"'\s]*([\w*{}\n, ]+)from\s*)?[\"'\s](.*?)[\"'\s].*)]],
            -- The Vim filetypes
            filetypes = { "typescript", "typescriptreact", "javascript", "react" },
            -- The filetypes that ripgrep supports (find these via `rg --type-list`)
            extensions = { "js", "ts" },
          },
          {
            regex = [[^%s*require%s*%(.-%)]],
            filetypes = { "lua" },
            extensions = { "lua" },
          },
        },
      },
    },
  }
end

return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    { "nvim-treesitter/nvim-treesitter" },
    { "nvim-telescope/telescope-fzf-native.nvim" },
    { "piersolenski/telescope-import.nvim" },
  },
  cmd = "Telescope",
  config = function(_, _)
    local telescope = require("telescope")
    local options = g_opt()
    telescope.setup(options)
    for _, ext in ipairs(options.extensions_list) do
      telescope.load_extension(ext)
    end
  end
}
