local map = function(mode, key, func, desc)
	return vim.keymap.set(mode, key, func, {desc = desc or ""})
end

map({"n", "i", "x"}, "<C-s>", "<cmd>write<cr>", "Save File")

map("n", "<leader>qq", "<cmd>qa<cr>", "Quit Neovim")

map("n", "<Esc>", "<cmd>nohlsearch<cr>", "Clear Search")

map("n", "<C-Left>", "<C-w>h", "Windows Left")
map("n", "<C-Down>", "<C-w>j", "Window Down")
map("n", "<C-Up>", "<C-w>k", "Window Up")
map("n", "<C-Right>", "<C-w>l", "Window Right")

map("n", "<A-Down>", "<cmd>move .+1<cr>==", "Move Line Down")
map("n", "<A-Up>", "<cmd>move .2<cr>==", "Move Line Up")
map("x", "<A-Down>", ":move '>+1<cr>gv=gv", "Move Selection Down")
map("x", "<A-Up>", ":move '<-2<cr>gv=gv", "Move Selection Up")

map("n", "<A-S-Down>", "<cmd>copy .<cr>", "Duplicate Line Down")
map("n", "<A-S-Up>", "<cmd>copy .-1<cr>", "Duplicate Line Up")
map("x", "<A-S-Down>", ":copy '><cr>gv", "Duplicate Selection Down")
map("x", "<A-S-Up>", ":copy '<-1<cr>gv", "Duplicate Selection Up")

-- Keep cursor centered
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzv")
map("n", "N", "Nzzv")

-- Paste without replacing clipboard
map("x", "p", '"_dP')

map("n", "<leader>wv", "<cmd>vsplit<cr>", "Split Vertical")
map("n", "<leader>wh", "<cmd>split<cr>", "Split Horizontal")
map("n", "<leader>wc", "<cmd>close<cr>", "Close Window")
map("n", "<leader>wo", "<cmd>only<cr>", "Close Other Windows")
map("n", "<leader>we", "<C-w>=", "Equal Window Size")

