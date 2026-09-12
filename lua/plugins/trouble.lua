return {
  "folke/trouble.nvim",
  cmd = "Trouble",
  opts = {
    modes = {
      diagnostics_buffer = {
        mode = "diagnostics",
        filter = { buf = 0 },
      },
    },
  },
  keys = {
    {
      "<leader>xx",
      function()
        require("trouble").toggle("diagnostics")
      end,
      desc = "Problems",
    },
    {
      "<leader>xX",
      function()
        require("trouble").toggle("diagnostics_buffer")
      end,
      desc = "Buffer Problems",
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
