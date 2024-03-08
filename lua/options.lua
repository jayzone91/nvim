local o = vim.o

-- Set Leader Keys
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Options
o.autoindent = true -- take indent for new line from previous line
o.autoread = true -- autom. read file when changed outside of Vim
o.background = "dark" -- "dark" or "light", used for highlight colors
o.backspace = "indent,eol,start" -- how backspace works at start of line
o.backup = false -- keep backup file after overwriting a file
o.clipboard = "unnamed" -- use the clipboard as the unnamed register
o.colorcolumn = "80" -- columns to highlight
o.completeopt = "menu,menuone,noinsert" -- options for Insert mode completion
o.confirm = true -- ask what to to about unsaved/read-only files
o.copyindent = true -- make "autoindent" use existing indent structure
o.cursorline = true -- highlight the screen line of the cursor
o.expandtab = true -- use spaces when <Tab> is inserted
o.hlsearch = true -- highlight matches with last search pattern
o.ignorecase = true -- ignore case in search patterns
o.incsearch = true -- highlight match while typing search pattern
o.laststatus = 1 -- tells when last window has status lines
o.linebreak = false -- wrap long lines at a blank
o.mouse = "a" -- enable the use of mouse clicks
o.mousehide = true -- hide mouse pointer while typing
o.number = true -- print the line number in front of each line
o.pumheight = 8 -- maximum number of items to show in the popup menu
o.pumwidth = 80 -- minimum width of the popup menu
o.relativenumber = true -- show relative line number in fron of each line
o.scrolloff = 8 -- minimum nr. of lines above and below cursor
o.shiftround = true -- round indent to multiple of shiftwidth
o.shiftwidth = 2 -- number of spaves to use for (auto)indent step
o.showmode = false -- message on status line to show current mode
o.showtabline = 1 -- tells when the tab pages line is displayed
o.sidescroll = 8 -- minimum number of columns to scroll horizontal
o.signcolumn = "yes" -- when and how to display the sign column
o.smartcase = true -- no ignore case when pattern has uppercase
o.smartindent = true -- smart autoindent for C programs
o.smarttab = true -- use "shiftwidth" when inserting <Tab>
o.softtabstop = 2 -- number of spaces that <Tab> uses while editing
o.splitbelow = true -- new window from split is below the current one
o.splitright = true -- new window os put right from the current one
o.tabstop = 2 -- number of spaces that <Tab> in file uses
o.title = true -- let Vim set the title of the window
o.wrap = false -- long lines wrap around the end of the file
