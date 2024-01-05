local map = require("utils.functions").map

return {
  "folke/zen-mode.nvim",
  lazy = true,
  event = "VeryLazy",
  opts = {},
  config = function()
    map("n", "<leader>zz", function()
      require("zen-mode").toggle({
        window = {
          width = 0.85,
        },
      })
    end, "Toggle Zen Mode")
  end,
}
