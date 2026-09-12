local map = function(mode, key, func, desc)
  return vim.keymap.set(mode, key, func, { desc = desc or "" })
end

map("n", "<leader>qq", "<cmd>qa<cr>", "Quit Neovim")

vim.keymap.set({ "i", "n", "s" }, "<esc>", function()
  vim.schedule(function()
    vim.cmd.nohlsearch()

    if vim.fn.has("nvim-0.13") == 1 then
      local ns = vim.api.nvim_create_namespace("nvim.multicursor")
      vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
    end
  end)

  return vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
end, { desc = "Escape and Clear hlsearch", silent = true, expr = true })

map("n", "<C-Left>", "<C-w>h", "Windows Left")
map("n", "<C-Down>", "<C-w>j", "Window Down")
map("n", "<C-Up>", "<C-w>k", "Window Up")
map("n", "<C-Right>", "<C-w>l", "Window Right")

map("n", "<A-Down>", "<cmd>move .+1<cr>==", "Move Line Down")
map("n", "<A-Up>", "<cmd>move .-2<cr>==", "Move Line Up")
map("x", "<A-Down>", ":move '>+1<cr>gv=gv", "Move Selection Down")
map("x", "<A-Up>", ":move '<-2<cr>gv=gv", "Move Selection Up")

map("n", "<A-S-Up>", "<cmd>copy .-1<cr>", "Duplicate Line Up")
map("n", "<A-S-Down>", "<cmd>copy .<cr>", "Duplicate Line Down")
map("x", "<A-S-Down>", ":copy '><cr>gv", "Duplicate Selection Down")
map("x", "<A-S-Up>", ":copy '<-1<cr>gv", "Duplicate Selection Up")

map("n", "<A-Left>", "<C-o>", "Navigate Back")
map("n", "<A-Right>", "<C-i>", "Navigate Forward")

-- better up and Down
vim.keymap.set(
  { "n", "x" },
  "j",
  "v:count == 0 ? 'gj' : 'j'",
  { desc = "Down", expr = true, silent = true }
)
vim.keymap.set(
  { "n", "x" },
  "<Down>",
  "v:count == 0 ? 'gj' : 'j'",
  { desc = "Down", expr = true, silent = true }
)
vim.keymap.set(
  { "n", "x" },
  "k",
  "v:count == 0 ? 'gk' : 'k'",
  { desc = "Up", expr = true, silent = true }
)
vim.keymap.set(
  { "n", "x" },
  "<Up>",
  "v:count == 0 ? 'gk' : 'k'",
  { desc = "Up", expr = true, silent = true }
)

map("i", "<Down>", "<C-o>gj")
map("i", "<Up>", "<C-o>gk")

-- Keep cursor centered
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Paste without replacing clipboard
map("x", "p", '"_dP')

map("n", "<leader>wv", "<cmd>vsplit<cr>", "Split Vertical")
map("n", "<leader>wh", "<cmd>split<cr>", "Split Horizontal")
map("n", "<leader>wc", "<cmd>close<cr>", "Close Window")
map("n", "<leader>wo", "<cmd>only<cr>", "Close Other Windows")
map("n", "<leader>we", "<C-w>=", "Equal Window Size")

-- Enter Normal mode
map(
  { "n", "i", "v", "x", "s", "o", "c" },
  "<C-c>",
  "<Esc>",
  "Enter Normal Mode"
)
map("t", "<Esc>", "<C-\\><C-n>", "Enter Normal Mode")

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
vim.keymap.set(
  "n",
  "n",
  "'Nn'[v:searchforward].'zv'",
  { expr = true, desc = "Next Search Result" }
)
vim.keymap.set(
  "x",
  "n",
  "'Nn'[v:searchforward]",
  { expr = true, desc = "Next Search Result" }
)
vim.keymap.set(
  "o",
  "n",
  "'Nn'[v:searchforward]",
  { expr = true, desc = "Next Search Result" }
)
vim.keymap.set(
  "n",
  "N",
  "'nN'[v:searchforward].'zv'",
  { expr = true, desc = "Prev Search Result" }
)
vim.keymap.set(
  "x",
  "N",
  "'nN'[v:searchforward]",
  { expr = true, desc = "Prev Search Result" }
)
vim.keymap.set(
  "o",
  "N",
  "'nN'[v:searchforward]",
  { expr = true, desc = "Prev Search Result" }
)
vim.keymap.set(
  { "i", "x", "n", "s" },
  "<C-s>",
  "<cmd>w<cr><esc>",
  { desc = "Save File" }
)
