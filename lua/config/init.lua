local M = {}

M.server = {
  lua_ls = {
    settings = {
      Lua = {
        completion = {
          callSnippet = "Replace",
        },
        diagnostics = {
          globals = {
            "vim",
          },
        },
      },
    },
  },
  tailwindcss = {},
  tsserver = {},
}

M.formatters = {
  "stylua", -- Format Lua
  "prettierd", -- format JS/TS/JSX/TSX/HTML/CSS etc
}

M.linters = {
  javascript = { "eslint_d" },
  typescript = { "eslint_d" },
  javascriptreact = { "eslint_d" },
  typescriptreact = { "eslint_d" },
  lua = { "luacheck" },
}

return M
