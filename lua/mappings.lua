-- Mappings

-- Save File with CTRL-S
vim.keymap.set({ "i", "x", "n", "s", "v" }, "<c-s>", "<cmd>w<cr><esc>")

-- Leave Insert mode with CTRL-C
vim.keymap.set("i", "<c-c>", "<esc>")

-- increment and decrement
vim.keymap.set("n", "+", "<c-a>")
vim.keymap.set("n", "-", "<c-x>")

-- delete word backwards
vim.keymap.set("n", "dw", 'vb"_d')

-- better up/down
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'j'", { expr = true, silent = true })

-- Duplicate Lines
vim.keymap.set("n", "<leader>k", "YP", { desc = "Duplicate Line Up" })
vim.keymap.set("n", "<leader><up>", "YP", { desc = "Duplicate Line Up" })
vim.keymap.set("n", "<leader>j", "Yp", { desc = "Duplicate Line Down" })
vim.keymap.set("n", "<leader><down>", "Yp", { desc = "Duplicate Line Down" })

-- Move Lines
vim.keymap.set("n", "<a-j>", "<cmd>m .+1<cr>==", { desc = "Move Line Down" })
vim.keymap.set("n", "<a-down>", "<cmd>m .+1<cr>==", { desc = "Move Line Down" })

vim.keymap.set("n", "<a-k>", "<cmd>m .-2<cr>==", { desc = "Move Line Up" })
vim.keymap.set("n", "<a-up>", "<cmd>m .-2<cr>==", { desc = "Move Line Up" })

-- Move Window using the <ctrl> key.
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
vim.keymap.set("n", "<C-left>", "<C-w>h", { desc = "Go to left window", remap = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
vim.keymap.set("n", "<C-down>", "<C-w>j", { desc = "Go to lower window", remap = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
vim.keymap.set("n", "<C-up>", "<C-w>k", { desc = "Go to upper window", remap = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })
vim.keymap.set("n", "<C-right>", "<C-w>l", { desc = "Go to right window", remap = true })

-- Clear Search with <esc>
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- quit
vim.keymap.set("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })

-- Split Window
vim.keymap.set("n", "<leader>ss", "<cmd>vsplit<cr>", { desc = "Split Screen Horizontal" })
vim.keymap.set("n", "<leader>sv", "<cmd>split<cr>", { desc = "Split Screen Vertical" })

-- Tabs
vim.keymap.set("n", "<C-t>", "<cmd>tabedit<cr>")
vim.keymap.set("n", "<Tab>", "<cmd>tabnext<cr>")
vim.keymap.set("n", "<S-Tab>", "<cmd>tabprev<cr>")
vim.keymap.set("n", "<leader>w", "<cmd>tabclose<cr>")

-- Easy Leave Terminal Mode
vim.keymap.set("t", "<esc>", "<C-\\>>C.N>")

-- Select all
vim.keymap.set("n", "<C-a>", "gg<S-v>G")
