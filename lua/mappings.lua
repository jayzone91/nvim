local map = function(mode, key, func, desc)
  return vim.keymap.set(mode, key, func, { desc = desc })
end


map("n", "<leader>qq", "<cmd>qa<cr>", "Quit Neovim")
map({ "i", "x", "n", "s", "v" }, "<C-s>", "<cmd>w<cr><esc>", "Save File")

-- map("n", "<leader>e", "<cmd>Ex<cr>", "Open Netrw")

-- Duplicate Lines
map("n", "<leader>k", "YP", "Duplicate Line Up")
map("n", "<leader><up>", "YP", "Duplicate Line Up")
map("n", "<leader>j", "Yp", "Duplicate Line Down")
map("n", "<leader><down>", "Yp", "Duplicate Line Down")

-- Move Lines
map("n", "<a-k>", "<cmd>m .-2<cr>==", "Move Line Up")
map("n", "<a-up>", "<cmd>m .-2<cr>==", "Move Line Up")
map("n", "<a-j>", "<cmd>m .+1<cr>==", "Move Line Down")
map("n", "<a-down>", "<cmd>m .+1<cr>==", "Move Line Down")

-- Split Window
map("n", "<leader>ss", "<cmd>vsplit<cr>", "Split Screen Horizontal")
map("n", "<leader>sv", "<cmd>split<cr>", "Split Screen Vertical")

-- Move Between Windows
map({ "i", "n", "v" }, "<c-h>", "<C-w>h", "Go To left Window")
map({ "i", "n", "v" }, "<c-left>", "<C-w>h", "Go To left Window")
map({ "i", "n", "v" }, "<c-j>", "<C-w>j", "Go To lower Window")
map({ "i", "n", "v" }, "<c-down>", "<C-w>j", "Go To lower Window")
map({ "i", "n", "v" }, "<c-k>", "<C-w>k", "Go To lower Window")
map({ "i", "n", "v" }, "<c-up>", "<C-w>k", "Go To lower Window")
map({ "i", "n", "v" }, "<c-l>", "<C-w>l", "Go To right Window")
map({ "i", "n", "v" }, "<c-right>", "<C-w>l", "Go To right Window")

-- Tabs
map("n", "<C-t>", "<cmd>tabedit<cr>", "Open New Tab")
map("n", "<Tab>", "<cmd>tabnext<cr>", "Go To Next Tab")
map("n", "<S-Tab>", "<cmd>tabprev<cr>", "Go To Prev Tab")
map("n", "<C-w>", "<cmd>tabclose<cr>", "Close active Tab")


-- Easy Leave Terminal Mode
map("t", "<esc>", "<C-\\>>C.N>")

-- Increment/decrement
map("n", "+", "<C-a>")
map("n", "-", "<C-x>")

-- Select all
map("n", "<C-a>", "gg<S-v>G")
