local M = {}

local Popup = require("nui.popup")
local event = require("nui.utils.autocmd").event

---@param opts nui_popup_options
M.create_popup = function(opts)
  ---@type nui_popup_options
  local base_opts = {
    enter = true,
    focusable = true,
    border = {
      style = "rounded",
    },
    buf_options = {
      filetype = "plaintext",
    },
    relative = "editor",
    position = "50%",
    size = {
      width = "90%",
      height = "78%",
    },
  }
  local popup = Popup(vim.tbl_deep_extend("force", base_opts, opts or {}))

  -- unmount component when cursor leaves buffer
  popup:on(event.BufLeave, function()
    popup:unmount()
  end)

  -- set map escape,q to close popup
  popup:map("n", "<Esc>", function()
    popup:unmount()
  end, { noremap = true })
  popup:map("n", "q", function()
    popup:unmount()
  end, { noremap = true })

  return popup
end

---@param opts nui_popup_options
M.popup = function(text, opts)
  local popup = M.create_popup(opts)
  popup:mount()
  vim.api.nvim_buf_set_lines(popup.bufnr, 0, 1, false, vim.split(text, "\n"))
end

return M
