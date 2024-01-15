local M = {}

M.setup = function()
  local function lspSymbol(name, icon)
    local hl = "DiagnosticSign" .. name
    vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
  end

  lspSymbol("Error", "󰅙")
  lspSymbol("Info", "󰋼")
  lspSymbol("Hint", "󰌵")
  lspSymbol("Warn", "")

  vim.diagnostic.config {
    virtual_text = {
      prefix = "",
    },
    signs = true,
    underline = true,
    update_in_insert = false,
  }

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "single",
  })
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "single",
    focusable = false,
    relative = "cursor",
  })

  -- Borders for LspInfo winodw
  local win = require "lspconfig.ui.windows"
  local _default_opts = win.default_opts

  win.default_opts = function(options)
    local opts = _default_opts(options)
    opts.border = "single"
    return opts
  end
end

M.setup_lsp_server = function(server)
  local lsp = require("lspconfig")
  local ok, opts = pcall(require, "plugins.configs.lsp." .. server)

  if not ok then
    return
  end

  if not is_empty(opts.active) and not opts.active then
    return
  end

  lsp[server].setup(opts)
end

M.setup_servers = function()
  local languages = require("plugins.configs.languages")

  local servers = languages.get_servers()

  for _, server in ipairs(servers) do
    M.setup_lsp_server(server)
  end
end


return {
  "neovim/nvim-lspconfig",
  dependencies = {
    {
      "hrsh7th/cmp-nvim-lsp"
    },
    {
      'kosayoda/nvim-lightbulb',
      config = function(_, _)
        require("nvim-lightbulb").setup({
          autocmd = { enabled = true }
        })
      end
    }
  },
  config = function(_, _)
    M.setup_servers()
    M.setup()
  end,
  lazy = false
}
