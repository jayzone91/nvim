return {
  -- fugitive.vim: A Git wrapper so awesome, it should be illegal
  "tpope/vim-fugitive",
  lazy = "VeryLazy",
  config = function()
    vim.keymap.set("n", "<leader>gaa", "<cmd>Git add .<cr>", { desc = "Git add all" })
    vim.keymap.set("n", "<leader>gb", "<cmd>Git blame<cr>", { desc = "Git blame" })
    vim.keymap.set("n", "<leader>gc", "<cmd>Git commit<cr>", { desc = "Git commit" })
    vim.keymap.set("n", "<leader>gp", "<cmd>Git push<cr>", { desc = "Git push" })
  end,
}
