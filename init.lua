-- Setting options
require("options")

vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.maplocalleader = " " -- Same for `maplocalleader`

-- Setting mappings
require("mappings")

-- lazy.nvim is a modern plugin manager for Neovim.
-- https://github.com/folke/lazy.nvim

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
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

local plugins = {
  -- Just Import complete "plugins" Folder
  { import = "plugins" },
}

local opts = {
  defaults = {
    lazy = true, -- should plugins be lazy-loaded?
    version = false, -- always use the latest git commit
  },
  install = {
    -- install missing plugins on startup
    missing = true,
  },
  checker = {
    -- automatically check for plugin updates
    enabled = true,
    notify = true,
  },
  change_detection = {
    -- automatically check for config file changes and reload the ui
    enabled = true,
    notify = false, -- get a notification when changes are found
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
}

require("lazy").setup(plugins, opts)

-- Include Autocmds
require("autocmds")
