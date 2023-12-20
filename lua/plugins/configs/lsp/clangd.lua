local opts = require("plugins.configs.lspconfig")

return {
  on_attach = opts.on_attach,
  capabilities = opts.capabilities,
}
