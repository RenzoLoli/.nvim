return {
  {
    "nvim-lua/plenary.nvim",
  },
  {
    "dstein64/vim-startuptime",
    lazy = false
  },
  {
    'RaafatTurki/hex.nvim',
    config = function(_, _)
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
}
