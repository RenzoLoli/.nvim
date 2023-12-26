function g_opts()
  local available_parsers = require("nvim-treesitter.parsers").available_parsers()
  local parsers = {}
  local languages = require("plugins.configs.languages").all

  for _, parser in ipairs(available_parsers) do
    if languages[parser] ~= nil then
      table.insert(parsers, parser)
    end
  end

  return {
    ensure_installed = parsers,

    highlight = {
      enable = true,
      use_languagetree = true,
    },

    indent = { enable = true },
  }
end

return {
  "nvim-treesitter/nvim-treesitter",
  cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
  run = ":TSUpdate",
  event = "BufRead",
  config = function(_, _)
    local treesitter = require("nvim-treesitter.configs")
    treesitter.setup(g_opts())
  end
}
