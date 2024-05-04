return {
  -- The undo history visualizer for VIM
  -- https://github.com/mbbill/undotree
  "mbbill/undotree",
  config = function()
    vim.keymap.set(
      "n",
      "<leader>u",
      "<cmd>UndotreeToggle<CR>",
      { desc = "Toggle Undo Tree" }
    )
  end,
}
