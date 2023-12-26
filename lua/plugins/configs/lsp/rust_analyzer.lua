local opts = require("plugins.addons.lspdefaults")
return {
  on_attach = opts.on_attach,
  capabilities = opts.capabilities,

  settings = {
    ["rust-analyzer"] = {
      workspace = {
        symbol = {
          search = {
            kind = "all_symbols"
          }
        }
      }
    },
  }
}
