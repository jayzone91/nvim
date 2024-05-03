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
}

M.formatters = {
  "stylua", -- Format Lua
  "prettierd", -- format JS/TS/JSX/TSX/HTML/CSS etc
}

return M
