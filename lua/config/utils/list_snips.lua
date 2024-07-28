local popup = require("config.utils.popup")

return function()
  local ft_list = require("luasnip").available()[vim.o.filetype]
  local ft_snips = {}
  for _, item in pairs(ft_list) do
    ft_snips[item.trigger] = item.name
  end
  local text = vim.inspect(ft_snips)
  popup.popup(text, {
    buf_options = {
      filetype = "lua"
    }
  })
end
