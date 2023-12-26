local opts = require("plugins.addons.lspdefaults")

local default_node_modules = vim.fn.getcwd() .. "/node_modules"

local cmd = {
  vim.fn.expand("$PWD/node_modules/.bin/ngserver"),
  "--stdio",
  "--tsProbeLocations",
  default_node_modules,
  "--ngProbeLocations",
  default_node_modules,
  "--experimental-ivy"
}

return {
  cmd = cmd,
  on_new_config = function(new_config, new_root_dir)
    new_config.cmd = cmd
  end,
  on_attach = opts.on_attach,
  capabilities = opts.capabilities,
  root_dir = require("lspconfig").util.root_pattern('angular.json', 'tsconfig.json', '.git'),
  filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx" }
}
