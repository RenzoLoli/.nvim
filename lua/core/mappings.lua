local mapper = function(mode, bind, action, opts)
  vim.keymap.set(mode, bind, action, opts)
end

mapper("n", "<leader>e", ":Ex<CR>", {desc = "Go to Three", silent = true})
mapper("n", "<leader>h", function() print("hello") end, {desc = "test"})
