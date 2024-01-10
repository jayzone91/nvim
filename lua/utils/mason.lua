local M = {}

M.servers = {
  "rust_analyzer",
  "lua_ls",
  "tsserver",
  "cssls",
  "marksman", -- markdown
  "jsonls",
  "html",
  "emmet_ls",
  "taplo", -- Toml
  "prismals",
  "tailwindcss",
}

M.formatters = {
  "stylua",
  "prettierd",
  "autopep8",
  "isort",
}

M.linters = {
  "eslint_d",
  "markdownlint",
}

return M
