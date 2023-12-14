local opt = vim.opt
local g = vim.g

--- globals ---
g.theme = "gruvbox"
-- g.theme_variant = ""
g.theme_mode = "dark" -- "dark" | "light"
-- g.theme_transparency = false

-- mapping
g.mapleader = " "

-- netrw
g.netrw_liststyle = 3

--- options ---
opt.laststatus = 3
opt.showmode = false

opt.clipboard = "unnamedplus"
opt.cursorline = true

opt.linebreak = true  -- wrap line 

-- Indenting
opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true
opt.tabstop = 2
opt.softtabstop = 2

opt.fillchars = { eob = " " }
opt.ignorecase = true
opt.smartcase = true
opt.mouse = "a"

-- Numbers
opt.number = true
opt.numberwidth = 2
opt.ruler = false

-- disable nvim intro
opt.shortmess:append "sI"

opt.signcolumn = "number" --- number | yes | no
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true
opt.timeoutlen = 400
opt.undofile = true

-- swap file
opt.swapfile = false

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append "<>[]hl"

-- disable some default providers
for _, provider in ipairs { "node", "perl", "python3", "ruby" } do
  vim.g["loaded_" .. provider .. "_provider"] = 0
end

-------------------------------------- autocmds ------------------------------------------
local autocmd = vim.api.nvim_create_autocmd

-- dont list quickfix buffers
autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.opt_local.buflisted = false
  end,
})

-------------------------------------- commands ------------------------------------------
local new_cmd = vim.api.nvim_create_user_command

new_cmd("Hello", function()
  print("Hello")
end, {})

new_cmd("ZorReloadCore", function()
  local vimpath = vim.fn.stdpath "config"
  vim.cmd("source " .. vimpath .. "/lua/core/init.lua")
  require("core.utils").load_theme()
end, {})

new_cmd("ZorListThemes", function()
  local themes = require("core.utils").list_themes("full")
  require("core.utils").echo(table.concat(themes, "\n"))
end, {})

-------------------------------------- post core ------------------------------------------
require("core.mappings")
