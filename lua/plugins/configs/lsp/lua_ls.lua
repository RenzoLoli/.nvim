local opts = require("plugins.configs.lspconfig")
local to_fullpath_expand_paths = function(paths)
  local full_expand = ""

  for _, ex in ipairs(paths) do
    full_expand = vim.fn.expand(ex) .. "\n" .. full_expand
  end

  return vim.split(full_expand, '\n')
end

local get_libraries = function ()
  local library = {}

  for _, path in ipairs(to_fullpath_expand_paths({
    "$VIMRUNTIME/lua/**/",
    vim.fn.stdpath('config') .. '/plugged/cmp.nvim/lua/cmp/types.lua',
    vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"
  })) do
    library[path] = true
  end

  return library
end

return {
  on_attach = opts.on_attach,
  capabilities = opts.capabilities,

  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = get_libraries(),
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
}
