local opts = require("plugins.addons.lspdefaults")
return {
  on_attach = opts.on_attach,
  capabilities = opts.capabilities,
}
