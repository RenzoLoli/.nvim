local on_attach = require("plugins.addons.lspdefaults").on_attach

local function get_project_rustanalyzer_settings()
  local handle = io.open(vim.fn.resolve(vim.fn.getcwd() .. '/./.rust-analyzer.json'))
  if not handle then
    return {}
  end
  local out = handle:read("*a")
  handle:close()
  local config = vim.json.decode(out)
  if type(config) == "table" then
    return config
  end
  return {}
end

-- Configure LSP through rust-tools.nvim plugin.
-- rust-tools will configure and enable certain LSP features for us.
-- See https://github.com/simrat39/rust-tools.nvim#configuration
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

  -- all the opts to send to nvim-lspconfig
  -- these override the defaults set by rust-tools.nvim
  -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
  server = {
    -- on_attach is a callback called when the language server attachs to the buffer
    on_attach = on_attach,
    settings = {
      -- to enable rust-analyzer settings visit:
      -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
      -- ["rust-analyzer"] = {
      --   cargo = {
      --     runBuildScripts = false
      --   },
      --   procMacro = {
      --     enable = true
      --   },
      --   -- enable clippy on save
      --   checkOnSave = {
      --     command = "clippy",
      --   },
      -- },
      ['rust-analyzer'] = vim.tbl_deep_extend(
        "force",
        {
          cargo = {
            allFeatures = true,
            loadOutDirsFromCheck = true,
            runBuildScripts = true
          },
          procMacro = {
            enable = true,
            ignored = {
              ["async-trait"] = { "async_trait" },
              ["napi-derive"] = { "napi" },
              ["async-recursion"] = { "async_recursion" },
            },
          },
          -- enable clippy on save
          checkOnSave = {
            allFeatures = true,
            command = "clippy",
            extraArgs = { "--no-deps" },
          },
        },
        get_project_rustanalyzer_settings(),
        {
        }
      )
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
