return {
  "nvim-treesitter/nvim-treesitter",
  build = function()
    require("nvim-treesitter.install").update({ with_sync = true })
  end,
  event = { "BufEnter" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "bash",
        "c",
        "css",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "prisma",
        "tsx",
        "typescript",
        "vim",
      },
      sync_install = false,
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
      autopairs = {
        enable = true,
      },
      autotag = {
        enable = true,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<c-space>",
          scope_incremental = "<c-s>",
          node_decremental = "<c-backspace>",
        },
      },
      text_objects = {
        select = {
          enable = true,
          lookahead = true,
        },
      },
    })
  end,
}
