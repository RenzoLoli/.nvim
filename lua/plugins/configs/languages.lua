local M = {}

M.all = {
    ["cpp"] = {
        server = "clangd",
        formatter = "clang-format",
        linter = "clang-tidy"
    },

    ["c"] = {
        server = "clangd",
        formatter = "clang-format",
        linter = "clang-tidy"
    },

    ["python"] = {
        server = "pyright",
        formatter = "black",
        linter = "flake8" -- ruff
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
        formatter = "clang-format", -- prettierd
        linter = "eslint_d"
    },

    ["typescript"] = {
        server = "tsserver",
        formatter = "clang-format", -- prettierd
        linter = "eslint_d"
    },

    ["html"] = {
        server = "html",
        formatter = "prettierd",
        linter = "tidy"
    },

    ["css"] = {
        server = "cssls",
        formatter = "prettierd",
        linter = "stylelint"
    },

    ["angular"] = {
        server = "angularls",
        formatter = "_",
        linter = "eslint_d"
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
    if config[group] and not set[config[group]]  then
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

return M
