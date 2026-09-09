local opt = vim.o

-- UI
opt.number = true
opt.relativenumber = false
opt.cursorline = true
opt.signcolumn = "yes"
opt.termguicolors = true
opt.showmode = false
opt.laststatus = 3
opt.cmdheight = 1

-- Editor
local tab = 2

opt.expandtab = true
opt.shiftwidth = tab
opt.tabstop = tab
opt.softtabstop = tab
opt.smartindent = true
opt.breakindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Navigation
opt.scrolloff = 6
opt.sidescrolloff = 8
opt.splitright = true
opt.splitbelow = true
opt.wrap = false

-- Mouse / Clipboard
opt.mouse = "a"
opt.clipboard = "unnamedplus"

-- Files
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.confirm = true

-- Responsivness
opt.updatetime = 250
opt.timeoutlen = 300

-- Completion
opt.completeopt = "menu,menuone,noselect"

-- Whitespace
opt.list = true
vim.opt.listchars = {
	tab = "→ ",
	trail = "·",
	nbsp = "␣",
}

-- Window Title
opt.title = true
