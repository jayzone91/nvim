local map = require("utils.functions").map

return {
  {
    "stevearc/oil.nvim",
    opts = {},
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("oil").setup({})

      map("n", "<leader>o", "<cmd>Oil<cr>", "Open Parent Directory")
    end,
  },
}
