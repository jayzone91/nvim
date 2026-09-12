return {
  "iamcco/markdown-preview.nvim",
  cmd = {
    "MarkdownPreview",
    "MarkdownPreviewStop",
    "MarkdownPreviewToggle",
  },
  build = "cd app && npm install",
  keys = {
    "<leader>cp",
    "<cmd>MarkdownPreviewToggle<CR>",
    desc = "Markdown Preview",
  },
  config = function()
    vim.cmd([[do FileType]])
  end,
}
