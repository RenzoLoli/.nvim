local opts = require("plugins.addons.lspdefaults")

return {
  on_attach = opts.on_attach,
  capabilities = opts.capabilities,
  filetypes = { "astro", "css", "eruby", "html", "htmldjango", "javascriptreact", "less", "pug", "sass", "scss", "svelte", "typescriptreact", "vue" }
}
