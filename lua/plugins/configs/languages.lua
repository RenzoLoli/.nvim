local M = {}

M.all = {

  ["cpp"] = {
    server = "clangd",
    formatter = "clang-format",
    linter = "clang-tidy"
  },

  ["emmet"] = {
    server = "emmet_ls",
    formatter = "_",
    linter = "_"
  },

  ["c"] = {
    server = "clangd",
    formatter = "clang-format",
    linter = "clang-tidy"
  },

  ["cs"] = {
    server = "omnisharp",
    formatter = "_",
    linter = "_"
  },

  ["python"] = {
    server = "pyright",
    formatter = "black",
    linter = "flake8"     -- ruff
  },

  ["lua"] = {
    server = "lua_ls",
    formatter = "stylua",
    linter = "luacheck"
  },

  ["rust"] = {
    server = "rust_analyzer",
    formatter = "rustfmt",
    linter = "_"
  },

  ["javascript"] = {
    server = "tsserver",
    formatter = "clang-format",     -- prettierd
    linter = "eslint_d"
  },

  ["typescript"] = {
    server = "tsserver",
    formatter = "clang-format",     -- prettierd
    linter = "eslint_d"
  },

  ["html"] = {
    server = "html",
    formatter = "prettierd",
    linter = "tidy"
  },

  ["json"] = {
    server = "jsonls",
    formatter = "_",
    linter = "_"
  },

  ["angular"] = {
    server = "angularls",
    formatter = "_",
    linter = "eslint_d"
  },

  ["css"] = {
    server = "cssls",
    formatter = "prettierd",
    linter = "stylelint"
  },

  ["react"] = {
    server = "tsserver",
    formatter = "stylua",
    linter = "luacheck"
  },

  ["markdown"] = {
    server = "marksman",
    formatter = "prettierd",
    linter = "vale"
  },

  ["zsh"] = {
    server = "bashls",
    formatter = "beautysh",
    linter = "zsh"
  },

  ["cmake"] = {
    server = "cmake",
    formatter = "cmakeformat",
    linter = "cmakelint"
  }
}

function to_list(group)
  local result = {}
  local set = {}

  for _, config in pairs(M.all) do
    if config[group] and config[group] ~= "_" and not set[config[group]] then
      table.insert(result, config[group])
      set[config[group]] = true
    end
  end

  return result
end

M.get_servers = function()
  return to_list("server")
end

M.get_linters = function()
  return to_list("linter")
end

M.get_formatters = function()
  return to_list("formatter")
end

M.get_languages = function()
  local keys = {}
  for key, _ in pairs(M.all) do
    table.insert(keys, key)
  end
  return keys
end

return M
