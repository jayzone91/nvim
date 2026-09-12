local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  vim.fn.mkdir(vim.fn.fnamemodify(lazypath, ":h"), "p")

  local result = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })

  if vim.v.shell_error ~= 0 then
    error("Failed to clone lazy.nvim\n" .. result)
  end
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
  defaults = { lazy = true },
  install = { colorscheme = { "rose-pine" } },
  change_detection = { notify = false },
  rocks = { enabled = false },
})
