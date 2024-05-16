local treesitter = require("nvim-treesitter.configs")
require("nvim-treesitter.install").prefer_git = true

---@diagnostic disable-next-line:missing-fields
treesitter.setup({
  highlight = { enable = true, additional_vim_regex_highlighting = false },
  indent = { enable = true },
  autotag = { enable = true },
  ensure_installed = {
    "json",
    "javascript",
    "typescript",
    "tsx",
    "yaml",
    "html",
    "css",
    "prisma",
    "markdown",
    "bash",
    "lua",
    "vim",
    "dockerfile",
    "gitignore",
    "query",
    "vimdoc",
    "c",
  },
  sync_install = false,
  auto_install = true,
  ignore_install = {},
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<C-space>",
      node_incremental = "<C-space>",
      scope_incremental = false,
      node_decremental = "<bs>",
    },
  },
})
