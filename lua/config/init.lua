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
  css_variables = {},
  cssls = {},
  docker_compose_language_service = {},
  dockerls = {},
  emmet_ls = {},
  gopls = {},
  html = {},
  intelephense = {},
  jsonls = {},
  marksman = {},
  prismals = {},
  pyright = {},
  rust_analyzer = {
    settings = {
      ["rust-analyzer"] = {
        diagnostics = {
          enable = true,
        },
      },
    },
  },
  taplo = {},
}

M.formatters = {
  "stylua", -- Format Lua
  "prettierd", -- format JS/TS/JSX/TSX/HTML/CSS etc
  "black", -- format Python
}

M.linters = {
  javascript = { "eslint_d" },
  typescript = { "eslint_d" },
  javascriptreact = { "eslint_d" },
  typescriptreact = { "eslint_d" },
  html = { "eslint_d" },
  lua = { "luacheck" },
  json = { "jsonlint" },
  jsonc = { "jsonlint" },
  markdown = { "markdownlint" },
  python = { "pylint" },
}

return M
