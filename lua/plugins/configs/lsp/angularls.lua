local opts = require("plugins.addons.lspdefaults")

local default_node_modules = vim.fn.getcwd() .. "/node_modules"

local cmd = {
  "node",
  default_node_modules .. "/@angular/language-server/index.js",
  "--stdio",
  "--tsProbeLocations",
  default_node_modules,
  "--ngProbeLocations",
  default_node_modules,
}

-- local root_dir = require("lspconfig").util.root_pattern('angular.json', 'tsconfig.json', '.git')

return {
  on_attach = opts.on_attach,
  capabilities = opts.capabilities,
  cmd = cmd,
  on_new_config = function(new_config, new_root_dir)
    require("plugins.addons.snippets").load_local_snippets("/angular")

    new_config.cmd = cmd
  end,
  -- root_dir = root_dir,
  filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx" }
}
