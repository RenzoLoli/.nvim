return {
  "neovim/nvim-lspconfig",
  opts = {
    diagnostics = {
      inlay_hints = {
        enabled = true,
        exclude = { "vue" },
      },
      codelens = {
        enabled = true
      }
    },
  },
}
