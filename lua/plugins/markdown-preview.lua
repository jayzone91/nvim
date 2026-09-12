return {
  "iamcco/markdown-preview.nvim",
  ft = { "markdown" },
  cmd = {
    "MarkdownPreview",
    "MarkdownPreviewStop",
    "MarkdownPreviewToggle",
  },
  build = "cd app && npm install",
  keys = {
    {
      "<leader>p",
      "<cmd>MarkdownPreviewToggle<CR>",
      desc = "Markdown Preview",
    },
  },
  config = function()
    vim.cmd([[do FileType]])
  end,
}
