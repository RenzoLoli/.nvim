local fn = vim.fn
local g = vim.g
local opt = vim.o
local M = {}

M.echo = function(str)
  vim.cmd "redraw"
  vim.api.nvim_echo({ { str, "bold" } }, true, {})
end

M.load_json = function(path)
  if type(path) == "nil" then
    return {}
  end
  local handle = io.open(path)
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

M.extend_local_file = function(filename)
  return vim.fn.resolve(vim.fn.getcwd() .. "/./" .. filename)
end

M.split_text = function (text, sep)
  vim.api.nvim_command('split')
  local id = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_set_lines(id, 0, -1, true, vim.split(text, sep))
end

M.inspect = function(value)
  M.split_text(value, "\n")
end

M.shell_call = function(args)
  local output = fn.system(args)
  assert(vim.ev.shell_error == 0, "External call failed with error code: " .. vim.v.shell_error .. "\n" .. output)
  return output
end

M.which = function(command)
  local is_windows = vim.fn.has("win32") == 1

  local cmd = is_windows and "where " or "which "
  local output = vim.fn.system(cmd .. command)
  return vim.fn.trim(output)
end

M.load_manager = function()
  local list = require("plugins.list")
  local mapped = {}
  for _, plug in ipairs(list) do
    local plugin = require("plugins.configs." .. plug)
    table.insert(mapped, plugin)
  end

  require("plugins.manager").setup(mapped)
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
  local modes = { "full", "default" }
  local mode = "default" -- "full" | "default"
  if not is_empty(_mode) then
    mode = _mode
    assert(vim.tbl_contains(modes, mode), "incorrect theme getter mode, try " .. vim.inspect(modes))
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

M.mapper = function(modes, bind, action, opts)
  if type(modes) == "string" then
    vim.keymap.set(modes, bind, action, opts)
  elseif type(modes) == "table" then
    for _, mode in ipairs(modes) do
      vim.keymap.set(mode, bind, action, opts)
    end
  else
    error("mapper - mode argument must be a string or a list of strings ")
  end
end

M.update_variable = function(varname, to)
  local path = vim.fn.stdpath("config") .. "core/init.lua"
  local file, _ = io.open(path, "r+")

  if not file then
    error("Cannot read 'core/init.lua'")
    return
  end

  local str = file:read("*a")
  file:close()

  str = str.gsub(varname .. "%s*=%s*\"[^\"]*\"", varname .. ' = "' .. to .. '"')
  file, _ = io.open(file, "w")

  if not file then
    error("Cannot write on 'core/init.lua'")
  end

  file:write(str)
  file:close()
end

return M
