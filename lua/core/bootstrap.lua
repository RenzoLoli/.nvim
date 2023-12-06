local M = {}
local fn = vim.fn

M.echo = function(str){
  vim.api.nvim_echo({ { str, "bold" }, true, {} })
}

return M
