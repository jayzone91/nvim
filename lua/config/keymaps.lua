local map = vim.keymap.set

--    ╭─────────────────────────────────────────╮
--    │               Normal mode               │
--    ╰─────────────────────────────────────────╯

map("n", "<Up>", "gk")
map("n", "<Down>", "gj")

--    ╭─────────────────────────────────────────╮
--    │               Visual mode               │
--    ╰─────────────────────────────────────────╯

map("x", "<Up>", "gk")
map("x", "<Down>", "gj")

--    ╭─────────────────────────────────────────╮
--    │                  Save                   │
--    ╰─────────────────────────────────────────╯

map({ "n", "i", "x" }, "<C-s>", "<cmd>write<cr>", {
	desc = "Save File",
})

--    ╭─────────────────────────────────────────╮
--    │                  Quit                   │
--    ╰─────────────────────────────────────────╯

map("n", "<leader>qq", "<cmd>qa<cr>", {
	desc = "Quit Neovim",
})

map("n", "<leader>qw", "<cmd>close<cr>", {
	desc = "Close Window",
})

--    ╭─────────────────────────────────────────╮
--    │             Split Navgation             │
--    ╰─────────────────────────────────────────╯

map("n", "<C-Left>", "<C-w>h", {
	desc = "Window Left",
})

map("n", "<C-Down>", "<C-w>j", {
	desc = "Window Down",
})

map("n", "<C-Up>", "<C-w>k", {
	desc = "Window Up",
})

map("n", "<C-Right>", "<C-w>l", {
	desc = "Window Right",
})

--    ╭─────────────────────────────────────────╮
--    │              Split Resize               │
--    ╰─────────────────────────────────────────╯

map("n", "<leader>wrh", "<cmd>vertical resize -2<cr>", {
	desc = "Resize Window Left",
})

map("n", "<leader>wrl", "<cmd>vertical resize +2<cr>", {
	desc = "Resize Window Right",
})

map("n", "<leader>wrk", "<cmd>resize +2<cr>", {
	desc = "Resize Window Up",
})

map("n", "<leader>wrj", "<cmd>resize -2<cr>", {
	desc = "Resize Window Down",
})

--    ╭─────────────────────────────────────────╮
--    │                 Splits                  │
--    ╰─────────────────────────────────────────╯

map("n", "<leader>wv", "<cmd>vsplit<cr>", {
	desc = "Split Vertical",
})

map("n", "<leader>wh", "<cmd>split<cr>", {
	desc = "Split Horizontal",
})

map("n", "<leader>wc", "<cmd>close<cr>", {
	desc = "Close Window",
})

map("n", "<leader>wo", "<cmd>only<cr>", {
	desc = "Close Other Windows",
})

map("n", "<leader>we", "<C-w>=", {
	desc = "Equal Window Sizes",
})

--    ╭─────────────────────────────────────────╮
--    │               Move lines                │
--    ╰─────────────────────────────────────────╯

map("n", "<A-Down>", "<cmd>move .+1<cr>==", {
	desc = "Move Line Down",
})

map("n", "<A-Up>", "<cmd>move .-2<cr>==", {
	desc = "Move Line Up",
})

map("x", "<A-Down>", ":move '>+1<cr>gv=gv", {
	desc = "Move Selection Down",
})

map("x", "<A-Up>", ":move '<-2<cr>gv=gv", {
	desc = "Move Selection Up",
})

--    ╭─────────────────────────────────────────╮
--    │             Duplicate lines             │
--    ╰─────────────────────────────────────────╯

map("n", "<A-S-Down>", "<cmd>copy .<cr>", {
	desc = "Duplicate Line Down",
})

map("n", "<A-S-Up>", "<cmd>copy .-1<cr>", {
	desc = "Duplicate Line Up",
})

map("x", "<A-S-Down>", ":copy '><cr>gv", {
	desc = "Duplicate Selection Down",
})

map("x", "<A-S-Up>", ":copy '<-1<cr>gv", {
	desc = "Duplicate Selection Up",
})

--    ╭─────────────────────────────────────────╮
--    │          Keep cursor centered           │
--    ╰─────────────────────────────────────────╯

map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

--    ╭─────────────────────────────────────────╮
--    │    Paste without replacing clipboard    │
--    ╰─────────────────────────────────────────╯

map("x", "p", '"_dP', {
	desc = "Paste Without Overwrite",
})

--    ╭─────────────────────────────────────────╮
--    │         Clear search highlight          │
--    ╰─────────────────────────────────────────╯

map("n", "<Esc>", "<cmd>nohlsearch<cr>", {
	desc = "Clear Search Highlight",
})
