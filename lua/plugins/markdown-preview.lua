return {
  "iamcco/markdown-preview.nvim",
  cmd = {
    "MarkdownPreview",
    "MarkdownPreviewStop",
    "MarkdownPreviewToggle",
  },
  build = "cd app && npm install",
  ft = { "markdown" },
  init = function()
    vim.g.mkdp_filetypes = { "markdown" }
  end,
  keys = {
    "<leader>p",
    "<cmd>MarkdownPreviewToggle<CR>",
    desc = "Markdown Preview",
  },
}
