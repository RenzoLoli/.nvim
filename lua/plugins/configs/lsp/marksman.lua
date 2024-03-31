local opts = require("plugins.addons.lspdefaults")

local function on_attach(client, buffr)
  local backup = client.server_capabilities.semanticTokensProvider

  opts.on_attach(client, buffr)

  client.server_capabilities.semanticTokensProvider = backup
end

return {
  on_attach = on_attach,
  capabilities = opts.capabilities,
}
