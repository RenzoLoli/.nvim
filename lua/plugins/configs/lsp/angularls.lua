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
-- En tu archivo de configuración de Lua
local api = vim.api
local lsp = vim.lsp
local root_dir = require("lspconfig").util.root_pattern('angular.json', 'tsconfig.json', '.git')

return {
  cmd = cmd,
  ---@diagnostic disable-next-line: unused-local
  require("plugins.addons.snippets").load_local_snippets("/angular"),
  on_new_config = function(new_config, new_root_dir)
    attach_tsserver = function()
      local bufnr = api.nvim_get_current_buf()
      local clients = vim.lsp.active_clients()
      local id = 0
      for _, client in ipairs(clients) do
        if client.config.name == "tsserver" then
          id = client.id
          lsp.buf_attach_client(bufnr, id)
          return
        end
      end
    end
    api.nvim_exec2([[
    augroup ts_on_buffer_enter
        autocmd!
        autocmd BufRead,BufNewFile ]] .. root_dir .. [[/*.ts
      local bufnr = api.nvim_get_current_buf()
      local clients = vim.lsp.active_clients()
      local id = 0
      for _, client in ipairs(clients) do
        if client.config.name == "tsserver" then
          id = client.id
          lsp.buf_attach_client(bufnr, id)
          return
        end
      end
    end

    augroup END
]], {
      output = false
    })

    new_config.cmd = cmd
  end,
  filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx" }
}
