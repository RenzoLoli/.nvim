local on_attach = require("plugins.addons.lspdefaults").on_attach
local utils = require("core.utils")

-- Configure LSP through rust-tools.nvim plugin.
-- rust-tools will configure and enable certain LSP features for us.
-- See https://github.com/simrat39/rust-tools.nvim#configuration

local default_analyzer_opts = {
  cargo = {
    allFeatures = true,
    loadOutDirsFromCheck = true,
    runBuildScripts = true
  },
  procMacro = {
    enable = true,
    -- ignored = {
    --   ["async-trait"] = { "async_trait" },
    --   ["napi-derive"] = { "napi" },
    --   ["async-recursion"] = { "async_recursion" },
    -- },
  },
  -- enable clippy on save
  checkOnSave = {
    allFeatures = true,
    command = "clippy",
    extraArgs = { "--no-deps" },
  },
}

local config_path = utils.extend_local_file(".rust-analyzer.json")
local analyzer_opts = vim.tbl_deep_extend(
  "force",
  default_analyzer_opts,
  utils.load_json(config_path)
)

local opts = {
  tools = {
    runnables = {
      use_telescope = true,
    },
    inlay_hints = {
      auto = true,
      show_parameter_hints = false,
      parameter_hints_prefix = "",
      other_hints_prefix = "",
    },
  },

  server = {
    on_attach = on_attach,
    settings = {
      ['rust-analyzer'] = analyzer_opts
    },
  },
}

return {
  "simrat39/rust-tools.nvim",
  event = "BufRead",
  config = function(_, _)
    local tools = require("rust-tools")
    tools.setup(opts)
    tools.inlay_hints.set()
    tools.inlay_hints.enable()
  end
}
