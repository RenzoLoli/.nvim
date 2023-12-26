local mapper = require("core.utils").mapper

mapper("n", "<leader>w", "<cmd> w! <CR>", { desc = "save file" })
mapper("n", "<c-s>", "<cmd> w! <CR>", { desc = "save file" })
mapper("n", "<leader>q", "<cmd> close <CR>", { desc = "close buffer" })
mapper("n", "<leader>E", "<cmd> NvimTreeToggle <CR>", { desc = "toggle nvimtree" })
mapper("n", "<leader>e", "<cmd> NvimTreeFocus <CR>", { desc = "focus nvimtree" })
mapper("n", "<leader>fu", "<cmd> UndotreeToggle <CR>", { desc = "toggle undotree" })

-- reemplazar texto
vim.keymap.set("v", "<C-r>", '"hy:%s/<C-r>h//gI<left><left><left>')
vim.keymap.set("n", "<C-r>", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")

-- clipboard copy
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")
vim.keymap.set("n", "Y", "yg$")

-- paste
mapper('n', '<leader>p', ':normal! "*p<cr>', { noremap = true, silent = true })
mapper('n', '<leader>P', ':normal! "+p<cr>', { noremap = true, silent = true })
mapper("x", "<leader>p", [["_dP]], { noremap = true, silent = true })
mapper("x", "<leader>p", [["_dP]], { noremap = true, silent = true })

-- tmux
mapper("n", "<c-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", { noremap = true, silent = true })

-- mover texto
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("n", "<A-k>", "V:m '<-2<CR>gv=gv")
vim.keymap.set("n", "<A-j>", "V:m '>+1<CR>gv=gv")

-- mejor mobilidad
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- pegado sin superposicion solo 1 vez
vim.keymap.set("x", "<leader>p", "\"_dP")

-- telescope

mapper("n", "<leader>fe", "<cmd> Telescope find_files <CR>", { noremap = true, silent = true })
mapper("n", "<leader>fb", "<cmd> Telescope buffers <CR>", { noremap = true, silent = true })
mapper("n", "<leader>ft", "<cmd> Telescope builtin include_extensions=true <CR>", { noremap = true })

-- LSP

mapper("n", "gD", function()
  vim.lsp.buf.declaration()
end, { desc = "LSP declaration" })

mapper("n", "gd", function()
  vim.lsp.buf.definition()
end, { desc = "LSP definition" })

mapper("n", "K", function()
  vim.lsp.buf.hover()
end, { desc = "LSP hover" })

mapper("n", "<leader>ff", function()
  vim.lsp.buf.format()
end, { desc = "LSP hover" })

mapper("n", "gi", function()
  vim.lsp.buf.implementation()
end, { desc = "LSP implementation" })

mapper("n", "<leader>ls", function()
  vim.lsp.buf.signature_help()
end, { desc = "LSP signature_help" })

mapper("n", "<leader>D", function()
  vim.lsp.buf.type_definition()
end, { desc = "LSP type_definition" })

mapper("n", "<leader>ra", function()
  require("plugins.addons.renamer").open()
end, { desc = "LSP rename" })

mapper("n", "<leader>ca", function()
  vim.lsp.buf.code_action()
end, { desc = "LSP code_action" })

mapper("n", "gr", function()
  vim.lsp.buf.references()
end, { desc = "LSP references" })

mapper("n", "<leader>lf", function()
  vim.diagnostic.open_float({ border = "rounded" })
end, { desc = "LSP diagnostic" })

mapper("n", "[d", function()
  vim.diagnostic.goto_prev({ float = { border = "rounded" } })
end, { desc = "LSP prev diagnostic" })

mapper("n", "]d", function()
  vim.diagnostic.goto_next({ float = { border = "rounded" } })
end, { desc = "LSP next diagnostic" })

mapper("n", "<leader>wa", function()
  vim.lsp.buf.add_workspace_folder()
end, { desc = "LSP add workspace folder" })

mapper("n", "<leader>wr", function()
  vim.lsp.buf.remove_workspace_folder()
end, { desc = "LSP remove workspace folder" })

mapper("n", "<leader>wl", function()
  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, { desc = "LSP list workspace folders" })
