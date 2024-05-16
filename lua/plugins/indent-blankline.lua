return {
  "lukas-reineke/indent-blankline.nvim",
  lazy = true,
  event = { "BufReadPre", "BufNewFile" },
  main = "ibl",
  opts = {
    indent = { char = "┊" },
  },
}
