return {
  -- markdown preview plugin for (neo)vim
  "iamcco/markdown-preview.nvim",
  event = "VeryLazy",
  ft = "markdown",
  -- install without yarn or npm
  build = function() vim.fn["mkdp#util#install"]() end,
  cmd = {
    "MarkdownPreviewToggle",
    "MarkdownPreview",
    "MarkdownPreviewStop",
  },
  config = function()
    vim.keymap.set("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>",
      { silent = true, desc = "Markdown: Toggle Preview" })
  end,
}
