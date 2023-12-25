return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        ensure_installed = {
          "c",
          "lua",
          "vim",
          "vimdoc",
          "query",
          "elixir",
          "heex",
          "javascript",
          "html",
          "typescript",
          "tsx",
          "dockerfile",
          "fish",
          "json",
          "markdown",
          "php",
          "python",
          "regex",
          "toml",
          "css",
          "prisma",
          "scss",
          "sql"
        },
        auto_install = true,
        ignore_install = {},
        modules = {},
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end
  },

}
