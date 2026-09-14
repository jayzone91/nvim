return {
  "folke/trouble.nvim",
  cmd = "Trouble",
  ---@type trouble.Config
  opts = {},
  keys = {
    {
      "<leader>xx",
      function()
        require("trouble").toggle("diagnostics")
      end,
      desc = "Problems",
    },
    {
      "<leader>xq",
      function()
        require("trouble").toggle("qflist")
      end,
      desc = "Quickfix",
    },
  },
}
