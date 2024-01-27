local opts = require("plugins.addons.lspdefaults")

return {
    dotnet_cmd = "dotnet", -- this is the default
    roslyn_version = "4.8.0-3.23475.7", -- this is the default
    on_attach = opts.on_attach, -- required
    capabilities = opts.capabilities, -- required
}
