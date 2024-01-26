local map = function(mode, key, func, opts)
  return vim.keymap.set(mode, key, func, opts)
end

-- Easy Commands
map({ "i", "x", "n", "s", "v" }, "<c-s>", "<cmd>w<cr><esc>")
map("i", "<c-c>", "<esc>")

-- better up/down
map(
  { "n", "x" },
  "j",
  "v:count == 0 ? 'gj' : 'j'",
  { expr = true, silent = true }
)
map(
  { "n", "x" },
  "<Down>",
  "v:count == 0 ? 'gj' : 'j'",
  { expr = true, silent = true }
)
map(
  { "n", "x" },
  "k",
  "v:count == 0 ? 'gk' : 'k'",
  { expr = true, silent = true }
)
map(
  { "n", "x" },
  "<Up>",
  "v:count == 0 ? 'gk' : 'j'",
  { expr = true, silent = true }
)

-- Duplicate Lines
map("n", "<leader>k", "YP", { desc = "Duplicate Line Up" })
map("n", "<leader><up>", "YP", { desc = "Duplicate Line Up" })
map("n", "<leader>j", "Yp", { desc = "Duplicate Line Down" })
map("n", "<leader><down>", "Yp", { desc = "Duplicate Line Down" })

-- Move Lines
map("n", "<a-j>", "<cmd>m .+1<cr>==", { desc = "Move Line Down" })
map("n", "<a-down>", "<cmd>m .+1<cr>==", { desc = "Move Line Down" })

map("n", "<a-k>", "<cmd>m .-2<cr>==", { desc = "Move Line Up" })
map("n", "<a-up>", "<cmd>m .-2<cr>==", { desc = "Move Line Up" })

-- Move Window using the <ctrl> key.
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
map("n", "<C-left>", "<C-w>h", { desc = "Go to left window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
map("n", "<C-down>", "<C-w>j", { desc = "Go to lower window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
map("n", "<C-up>", "<C-w>k", { desc = "Go to upper window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })
map("n", "<C-right>", "<C-w>l", { desc = "Go to right window", remap = true })

-- Clear Search with <esc>
map(
  { "i", "n" },
  "<esc>",
  "<cmd>noh<cr><esc>",
  { desc = "Escape and clear hlsearch" }
)

-- quit
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })

-- Split Window
map("n", "<leader>ss", "<cmd>vsplit<cr>", { desc = "Split Screen Horizontal" })
map("n", "<leader>sv", "<cmd>split<cr>", { desc = "Split Screen Vertical" })

-- Tabs
map("n", "<C-t>", "<cmd>tabedit<cr>")
map("n", "<Tab>", "<cmd>tabnext<cr>")
map("n", "<S-Tab>", "<cmd>tabprev<cr>")
map("n", "<leader>w", "<cmd>tabclose<cr>")

-- Easy Leave Terminal Mode
map("t", "<esc>", "<C-\\>>C.N>")

-- Select all
map("n", "<C-a>", "gg<S-v>G")
