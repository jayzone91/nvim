local map = vim.keymap.set

-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Move to window using the <ctrl> arrow keys
map("n", "<leader><Left>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<leader><Down>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<leader><Up>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<leader><Right>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- save file
map({ "i", "x", "n", "s" }, "<C-s>", "<esc><cmd>w<cr><esc>", { desc = "Save File" })

map({ "i", "n" }, "<leader>qq", "<Esc>:qa<cr>", { desc = "Quit NeoVim" })

map("n", "<leader>pu", "<cmd>Lazy update<CR>", { desc = "Search for Updates" })

-- VS Code Shortcuts
vim.keymap.set("n", "<A-Up>", "yyP", { desc = "Dupcliate Line Up" })
vim.keymap.set("i", "<A-Up>", "<Esc>yyPgi", { desc = "Duplicate Line Up" })
vim.keymap.set("n", "<A-Down>", "yyp", { desc = "Duplicate Line Down" })
vim.keymap.set("i", "<A-Down>", "<Esc>yypgi", { desc = "Duplicate Line Down" })

vim.keymap.set("n", "<C-Up>", ":m .-2<CR>==", { desc = "Move line Up" })
vim.keymap.set("i", "<C-Up>", "<Esc>:m .-2<CR>==gi", { desc = "Move line Up" })
vim.keymap.set("n", "<C-Down>", ":m .+1<CR>==", { desc = "Move line Down" })
vim.keymap.set("i", "<C-Down>", "<Esc>:m .+1<CR>==gi", { desc = "Move line Down" })

-- Exit Terminal Mode
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal Mode" })

map("n", "<leader>ss", ":vsplit<CR>", { desc = "Split Vertical" })
map("n", "<leader>sv", ":split<CR>", { desc = "Split Horziontal" })

map("n", "<leader>R", ":restart<CR>", { desc = "Restart NeoVim" })
