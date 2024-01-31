return {
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    config = function() require("gitsigns").setup() end,
  },
  {
    "tpope/vim-fugitive",
    event = "VeryLazy",
    config = function()
      vim.keymap.set(
        "n",
        "<leader>gaa",
        ":Git add .<CR>",
        { desc = "Git Add All" }
      )
      vim.keymap.set(
        "n",
        "<leader>gb",
        ":Git blame<CR>",
        { desc = "Git Blame" }
      )
      vim.keymap.set(
        "n",
        "<leader>gc",
        ":Git commit<CR>",
        { desc = "Git Commit" }
      )
      vim.keymap.set("n", "<leader>gp", ":Git push<CR>", { desc = "Git Push" })
    end,
  },
}
