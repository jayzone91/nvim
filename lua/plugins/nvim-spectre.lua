return {
  -- Find the enemy and replace them with dark power.
  -- https://github.com/nvim-pack/nvim-spectre
  "nvim-pack/nvim-spectre",
  cond = function() return vim.fn.executable("sed") == 1 end,
  config = function()
    vim.keymap.set(
      "n",
      "<leader>S",
      "<cmd>lua require(\"spectre\").toggle()<CR>",
      {
        desc = "Toggle Spectre",
      }
    )
    vim.keymap.set(
      "n",
      "<leader>sw",
      "<cmd>lua require(\"spectre\").open_visual({select_word=true})<CR>",
      {
        desc = "Search current word",
      }
    )
    vim.keymap.set(
      "v",
      "<leader>sw",
      "<esc><cmd>lua require(\"spectre\").open_visual()<CR>",
      {
        desc = "Search current word",
      }
    )
    vim.keymap.set(
      "n",
      "<leader>sp",
      "<cmd>lua require(\"spectre\").open_file_search({select_word=true})<CR>",
      {
        desc = "Search on current file",
      }
    )
  end,
}
