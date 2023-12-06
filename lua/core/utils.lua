local fn = vim.fn
local g = vim.g
local opt = vim.o
local M = {}

M.echo = function(str)
  vim.cmd "redraw"
  vim.api.nvim_echo({ { str, "bold" }, true, {} })
end

M.shell_call = function(args)
  local output = fn.system(args)
  assert(vim. ev.shell_error == 0, "External call failed with error code: " .. vim.v.shell_error .. "\n" .. output)
end

M.load_manager = function()
  local list = require("plugins.list")
  require("plugins.manager").setup(list)
end

function is_empty(value)
  return value == nil or value == ""
end
M.load_theme = function()
  local themes = require("core.themes")

  local theme = themes.default_theme
  if not is_empty(g.theme) then theme = g.theme end

  local variant = ""
  if not is_empty(g.theme_variant) then variant = g.theme_variant end

  local mode = themes.default_mode
  if not is_empty(g.theme_mode) then mode = g.theme_mode end

  local transparency = themes.default_transparency
  if not is_empty(g.theme_transparency) then mode = g.theme_transparency end

  -- update mode
  opt.background = mode

  -- update theme configs
  local params = themes.themes[theme]
  if not is_empty(params) then
    local config = params.config
    if is_empty(variant) then
      variant = params.variant
    end
    if not is_empty(config) then
      config(variant)
    end
  end

  vim.cmd("colorscheme " .. theme)
end

M.list_themes = function(_mode)
  local _themes = require("core.themes")
  local themes = _themes.themes
  local modes = {"full", "default"}
  local mode = "default" -- "full" | "default"
  if not is_empty(_mode) then
    mode = _mode
    assert(vim.tbl_contains(modes, mode), "incorrect theme getter mode, try ".. vim.inspect(modes))
  end

  local full_themes = {}
  for theme, params in pairs(themes) do
    if mode == "default" or is_empty(params) then
      table.insert(full_themes, theme)
    else
      for i, variant in ipairs(params.variants) do
        table.insert(full_themes, theme .. " " .. variant)
      end
    end
  end

  return full_themes
end

return M
