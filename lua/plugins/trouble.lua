return {
  "folke/trouble.nvim",
  dependencies = "nvim-tree/nvim-web-devicons",
  opts = {
    position = "right",
  },
  config = function()
    vim.keymap.set(
      "n",
      "<leader>xx",
      "<cmd>TroubleToggle<cr>",
      { desc = "Toggle Trouble" }
    )
  end,
}
