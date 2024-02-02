local M = {}

M.statusline_clients = function()
  local text = ""
  local clients = vim.lsp.get_clients()

  if #clients == 0 then
    return text
  end

  for _, client in ipairs(clients) do
    text = text .. "[" .. client.name .. "] "
  end

  return text
end

M.load_client = function ()
end

return  M
