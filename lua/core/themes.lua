local M = {}

M.themes = {
  ["monokai-pro"] = {
    variants = {
      "classic", "octagon", "pro", "machine", "ristretto", "spectrum"
    },
    default = "classic",
    config = function(variant)
      require("monokai-pro").setup({filter = variant})
    end
  },
  ["tokyonight"] = {
    variants = {
      "storm", "moon", "night", "day"
    },
    default = "storm",
    config = function(variant)
      require("tokyonight").setup({style = variant})
    end
  },
  ["gruvbox"] = "",
  ["sonokai"] = ""
}

M.default_theme  = "tokyonight"
M.default_variant = "storm"
M.default_mode = "dark"
M.default_transparency = false

return M
