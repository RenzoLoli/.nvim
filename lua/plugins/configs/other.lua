local mapper = require("core.utils").mapper

return {
  {
    "nvim-lua/plenary.nvim",
    lazy = false
  },
  {
    "dstein64/vim-startuptime",
    lazy = false
  },
  {
    'RaafatTurki/hex.nvim',
    event = "BufRead",
    config = function(_, _)
      require("hex").setup()
    end,
  },
  {
    "mbbill/undotree",
    config = function(_, _)
      vim.cmd [[
        let g:undotree_WindowLayout = 2
        let g:undotree_SetFocusWhenToggle = 1
      ]]
    end,
    event = "InsertEnter",
    lazy = false,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      fast_wrap = {},
      disable_filetype = { "TelescopePrompt", "vim" },
    },
    config = function(_, opts)
      require("nvim-autopairs").setup(opts)

      -- setup cmp for autopairs
      local cmp_autopairs = require "nvim-autopairs.completion.cmp"
      require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
  },
  {
    "numToStr/Comment.nvim",
    event = "InsertEnter",
    keys = {
      { "gcc", mode = "n",          desc = "Comment toggle current line" },
      { "gc",  mode = { "n", "o" }, desc = "Comment toggle linewise" },
      { "gc",  mode = "x",          desc = "Comment toggle linewise (visual)" },
      { "gbc", mode = "n",          desc = "Comment toggle current block" },
      { "gb",  mode = { "n", "o" }, desc = "Comment toggle blockwise" },
      { "gb",  mode = "x",          desc = "Comment toggle blockwise (visual)" },
    },
    config = function(_, opts)
      require("Comment").setup(opts)

      mapper("n", "<leader>/", function()
        require("Comment.api").toggle.linewise.current()
      end, { desc = "toggle comment" })

      mapper("v", "<leader>/", "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
        { desc = "toggle comment" })
    end,
  },
}
