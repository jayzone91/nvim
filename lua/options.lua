--[[ 
-- General Settings --
--]]

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.o.expandtab = true -- use spaces when <Tab> is inserted
vim.o.tabstop = 2 -- number of spaces that <Tab> in file uses
vim.o.softtabstop = 2 -- number of spaces that <Tab> uses while editing
vim.o.shiftwidth = 2 -- number of spaces to use for (auto)indent step
vim.o.wrap = false -- long lines wrap and continue on the next line
vim.o.number = true -- print the line number in front of each line
vim.o.relativenumber = true -- show relative line numbers
vim.o.background = "dark" -- "dark" or "light", used for highlight colors
vim.o.colorcolumn = "80" -- columns to highlight
vim.o.signcolumn = "yes" -- when and how to display the sign column
vim.o.termguicolors = true -- Use more colors
vim.o.timeout = true -- time out on mappings and key codes
vim.o.timeoutlen = 300 -- time out time in milliseconds
vim.o.title = true -- let Vim set the title of the window
vim.o.updatetime = 300 -- after this many milliseconds flush swap file
vim.o.cursorline = true -- highlight the screen line of the cursor
vim.o.mouse = "a" -- enable the use of mouse clicks
vim.o.scrolloff = 8 -- minimum nr. of lines above and below cursor
vim.o.autoindent = true -- take indent for new line from previous line
vim.o.backspace = "indent,eol,start" -- how backspace works at start of line
vim.o.backup = false -- keep backup file after overwriting a file
vim.o.confirm = true -- ask what to do about unsaved/read-only files
vim.o.showmode = false -- message on status line to show current mode
vim.o.showtabline = 1 -- tells when the tab pages line is displayed
-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.inccommand = "nosplit" -- preview incremental substitute
vim.o.smartcase = true -- no ignore case when pattern has uppercase
vim.o.ignorecase = true -- ignore case when completing file names
vim.o.smarttab = true -- use 'shiftwidth' when inserting <Tab>
vim.o.splitbelow = true -- new window from split is below the current one
vim.o.splitright = true -- new window is put right of the current one
vim.o.swapfile = true -- whether to use a swapfile for a buffer
vim.o.conceallevel = 3 -- whether concealable text is shown or hidden
vim.o.list = true -- show <Tab> and <EOL>
vim.o.foldenable = true -- set to display all folds open
vim.o.foldlevelstart = 99 -- 'foldlevel' when starting to edit a file
vim.o.foldcolumn = "1" -- width of the column used to indicate folds
vim.o.foldlevel = 99 -- close folds with a level higher than this
vim.o.completeopt = "menuone,noselect" -- Set completeopt to have a better completion experience
vim.o.hlsearch = false -- Set highlight on search
-- Sync Clipboard between OS and Neovim
-- Remove this option if you want your OS clipboard to remain independant
vim.o.clipboard = "unnamedplus"
vim.o.formatoptions = "jcroqlnt" -- tcqj
vim.o.grepformat = "%f:%l:%c:%m"
vim.o.grepprg = "rg --vimgrep"
vim.o.pumblend = 10 -- Popup blend
vim.o.pumheight = 10 -- Maximum number of entries in a popup
vim.o.shiftround = true -- Round indent
vim.opt.shortmess:append({ W = true, I = true, c = true, C = true })
vim.o.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
vim.o.wildmode = "longest:full,full" -- Command-line completion mode
vim.o.winminwidth = 5 -- Minimum window width
vim.opt.fillchars = {
  foldopen = "",
  foldclose = "",
  -- fold = "⸱",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0
