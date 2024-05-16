-- Vim / NeoVim Options.
-- https://neovim.io/doc/user/quickref.html#option-list

vim.cmd("let g:netrw_liststyle = 3")

local o = vim.o

o.autoindent = true -- take indent for new line from previous line
o.autoread = true -- autom. read file when changed outside of Vim
o.background = "dark" -- "dark" or "light", used for highlight colors
o.backspace = "indent,eol,start" -- how backspace works at start of line
o.showmode = false
o.completeopt = "menu,menuone,noinsert" -- options for Insert mode completion
o.confirm = true -- ask what to to about unsaved/read-only files
o.copyindent = true -- make "autoindent" use existing indent structure
o.expandtab = true -- use spaces when <Tab> is inserted
o.hlsearch = true -- highlight matches with last search
o.ignorecase = true -- ignore case in search patterns
o.mouse = "a" -- enable the use of mouse clicks
o.number = true -- print the line number in front of each line
o.relativenumber = true -- show relative line number in fron of each line
vim.opt.clipboard:append("unnamedplus") -- use the clipboard as the unnamed register
o.smartcase = true -- no ignore case when pattern has uppercase
o.signcolumn = "yes" -- when and how to display the sign column
o.updatetime = 250
o.timeoutlen = 300
o.splitright = true
o.splitbelow = true
o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.inccommand = "split"
o.cursorline = true
o.scrolloff = 10
o.smartindent = true -- smart autoindent for C programs
o.smarttab = true -- use "shiftwidth" when inserting <Tab>
o.softtabstop = 2 -- number of spaces that <Tab> uses while editing
o.tabstop = 2 -- number of spaces that <Tab> in file uses
o.title = true -- let Vim set the title of the window
o.wrap = false -- long lines wrap around the end of the file
o.expandtab = true
o.shiftwidth = 2
o.termguicolors = true
o.swapfile = false
