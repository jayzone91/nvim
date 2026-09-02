-- ╭─────────────────────────────────╮
-- │      Meine NeoVim Config.       │
-- │     Erstellt am 01.09.2026      │
-- │    Author: Johannes Kirchner    │
-- ╰─────────────────────────────────╯

vim.loader.enable()

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.options")
require("config.keymaps")
require("config.autocmds")

require("plugins")
