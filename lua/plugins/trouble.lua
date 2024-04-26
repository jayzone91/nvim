return {
  "folke/trouble.nvim",
  branch = "dev",
  config = function()
    require("trouble").setup({})

    vim.keymap.set(
      "n",
      "<leader>xx",
      ":Trouble diagnostics toggle<cr>",
      { desc = "Diagnostics (Trouble)" }
    )
  end,
}
