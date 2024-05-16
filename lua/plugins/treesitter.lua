return {
  "nvim-treesitter/nvim-treesitter",
  lazy = true,
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag",
  },
  config = function() require("config.treesitter") end,
}
