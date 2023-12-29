local M = {}

M.load_snippets = function(path)
  require("luasnip.loaders.from_vscode").lazy_load {
    paths = path or ""
  }
end

M.load_local_snippets = function(path)
  local t = type(path)
  local lpath = vim.g.vscode_snippets_path

  if t == "string" then
    path = lpath .. path
  elseif t == "table" then
    for i, value in ipairs(path) do
      path[i] = (string.match(value, lpath) and value or (lpath .. value))
    end
  else
    print("invalid path: " .. string.format("%s", path))
    return
  end

  M.load_snippets(path)
end

return M
