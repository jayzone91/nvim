return {
  -- markdown preview plugin for (neo)vim
  -- https://github.com/iamcco/markdown-preview.nvim
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  ft = { "markdown" },
  build = function() vim.fn["mkdp#util#install"]() end,
  config = function()
    vim.keymap.set(
      "n",
      "<leader>tm",
      "<cmd>MarkdownPreviewToggle<CR>",
      { desc = "Toggle MarkdownPreview" }
    )
  end,
}
