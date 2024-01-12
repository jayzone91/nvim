local map = require("utils.functions").map
-- local cowboy = require("utils.functions").cowboy

-- cowboy()

map("n", "<leader>qq", "<cmd>qa<cr>", "Quit Neovim")
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", "Save File")

-- Dupe Lines
map("n", "<leader>k", "YP", "Duplicate Line Up")
map("n", "<leader>j", "Yp", "Duplicate Line Down")

-- Move Lines
map("n", "<a-k>", "<cmd>m .-2<cr>==", "Move Line Up")
map("n", "<a-j>", "<cmd>m .+1<cr>==", "Move Line Up")

-- Split Window
map("n", "<leader>ss", "<cmd>vsplit<cr>", "Split Screen")
map("n", "<leader>sv", "<cmd>split<cr>", "Split Screen")
map({ "i", "n" }, "<C-l>", "<C-w>h", "Go to left Window")
map({ "i", "n" }, "<C-k>", "<C-w>k", "Go to upper Window")
map({ "i", "n" }, "<C-j>", "<C-w>j", "Go to lower Window")
map({ "i", "n" }, "<C-h>", "<C-w>l", "Go to right Window")
map("n", "te", "<cmd>tabedit<cr>", "New Tab")
map("n", "<Tab>", "<cmd>tabnext<cr>", "Next Tab")
map("n", "<s-Tab>", "<cmd>prevtab<cr>", "Prev Tab")
map("n", "<leader>sw", "<cmd>tabclose<cr>", "Close active Tab")

-- Easy Leave in Terminal mode
map("t", "<esc>", "<C-\\><C-N>", "")

-- Clear Search
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", "")

-- Diagnositic keymaps
map("n", "[d", vim.diagnostic.goto_prev, "Go to previous diagnostic message")
map("n", "]d", vim.diagnostic.goto_next, "Go to next diagnostic message")
map(
  "n",
  "<leader>de",
  vim.diagnostic.open_float,
  "Open floating diagnostic message"
)
map("n", "<leader>dq", vim.diagnostic.setloclist, "Open diagnostics list")

-- disable arrow keys to better lern vim motions.
map({"n","i","v"}, "<Up>", "", "")
map({"n","i","v"}, "<Down>", "", "")
map({"n","i","v"}, "<Left>", "", "")
map({"n","i","v"}, "<Right>", "", "")
