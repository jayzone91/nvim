return {
  "uga-rosa/ccc.nvim",
  config = function()
    require("ccc").setup({
      highlighter = {
        auto_enable = true,
        lsp = true,
      },
    })

    vim.keymap.set(
      "n",
      "<leader>C",
      "<cmd>CccHighlighterToggle<CR>",
      { desc = "Toggle CCC Colors" }
    )
  end,
}
