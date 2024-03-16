require("options")
require("mappings")
require("autocmds")

-- Lazy Plugin Manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  defaults = {
    lazy = true,
    version = nil,
  },
  spec = {
    { import = "plugins" },
  },
  install = {
    missing = true,
  },
  checker = {
    enabled = true,
    notify = true,
  },
  performance = {
    disabled_plugins = {
      "gzip",
      "tarPlugin",
      "tohtml",
      "tutor",
      "zipPlugin",
    },
  },
}, {})
