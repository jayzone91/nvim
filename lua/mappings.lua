local map = function(mode, key, func, desc)
  return vim.keymap.set(mode, key, func, {desc = desc})
end


map("n", "<leader>qq", "<cmd>qa<cr>", "Quit Neovim")
map({"i", "x", "n", "s"}, "<C-s>", "<cmd>w<cr><esc>", "Save File")

-- Dupe Lines
map("n", "<leader><up>", "YP", "Duplicate Line Up")
map("n", "<leader><down>", "Yp", "Duplicate Line Down")

-- Move Lines
map("n", "<a-up>", "<cmd>m .-2<cr>==", "Move Line Up")
map("n", "<a-down>", "<cmd>m .+1<cr>==", "Move Line Up")

-- Split Window
map("n", "<leader>ss", "<cmd>vsplit<cr>", "Split Screen")
map("n", "<leader>sv", "<cmd>split<cr>", "Split Screen")
map({"i", "n"}, "<C-left>", "<C-w>h", "Go to left Window")
map({"i", "n"}, "<C-up>", "<C-w>k", "Go to upper Window")
map({"i", "n"}, "<C-down>", "<C-w>j", "Go to lower Window")
map({"i", "n"}, "<C-right>", "<C-w>l", "Go to right Window")
map("n", "te", "<cmd>tabedit<cr>", "New Tab")
map("n", "<Tab>", "<cmd>tabnext<cr>", "Next Tab")
map("n", "<s-Tab>", "<cmd>prevtab<cr>", "Prev Tab")
map("n", "<leader>sw", "<cmd>tabclose<cr>", "Close active Tab")

-- Easy Leave in Terminal mode
map("t", "<esc>", "<C-\\><C-N>", "")

-- Clear Search
map({"i", "n"}, "<esc>", "<cmd>noh<cr><esc>", "")
