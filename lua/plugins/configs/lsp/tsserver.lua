local opts = require("plugins.addons.lspdefaults")

local root_dir = require("lspconfig").util.root_pattern('angular.json', "package.json", 'tsconfig.json', "jsconfig.json",
  '.git')

return {
  on_attach = opts.on_attach,
  capabilities = opts.capabilities,
  -- filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" , "html"},
  -- root_dir = root_dir
}
