return {
  -- Neovim plugin to improve the default vim.ui interfaces
  "stevearc/dressing.nvim",
  lazy = false,
  config = function() require("dressing").setup() end,
}
