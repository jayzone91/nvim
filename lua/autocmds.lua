-- vim.api.nvim_create_autocmd({ "BufWritePre" }, {
--  group = vim.api.nvim_create_augroup("format_on_save", { clear = true }),
--  pattern = { "*" },
--  callback = function()
--    vim.lsp.buf.format()
--  end,
--  desc = "Format Buffer on Save",
--})

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = vim.api.nvim_create_augroup("edit_text", { clear = true }),
  pattern = { "gitcommit", "markdown", "txt" },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.wrap = true
  end,
  desc = "Activate spell checking and line wrapping on text files",
})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
  pattern = "*",
  callback = function() vim.highlight.on_yank({ timeout = 200, visual = true }) end,
  desc = "Highlight selection on yank",
})

vim.api.nvim_create_autocmd("VimResized", {
  group = vim.api.nvim_create_augroup("WinResize", { clear = true }),
  pattern = "*",
  command = "wincmd =",
  desc = "Auto-resize windows on terminal buffer resize.",
})
