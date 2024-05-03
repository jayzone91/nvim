-- Vim Mappings (Plugin specific mappings are in the plugin specs)

---@param mode string|table
---@param key string
---@param func string|function
---@param opts table?
local map = function(mode, key, func, opts)
  vim.keymap.set(mode, key, func, opts or {})
end

-- save file with CTRL-S
map(
  { "i", "x", "n", "s", "v" },
  "<c-s>",
  "<cmd>w<cr><esc>",
  { desc = "Save File" }
)

-- Leave Insert mode with CTRL-c
map("i", "<c-c>2", "<esc>")

-- Increment and decrement
map("n", "+", "<c-a>")
map("n", "-", "<c-x>")

-- better up/down
map(
  { "n", "x" },
  "<down>",
  "v:count == 0 ? 'gj' : 'j'",
  { expr = true, silent = true }
)
map(
  { "n", "x" },
  "j",
  "v:count == 0 ? 'gj' : 'j'",
  { expr = true, silent = true }
)
map(
  { "n", "x" },
  "<up>",
  "v:count == 0 ? 'gk' : 'k'",
  { expr = true, silent = true }
)
map(
  { "n", "x" },
  "k",
  "v:count == 0 ? 'gk' : 'k'",
  { expr = true, silent = true }
)

-- Duplicate Lines
map("n", "<leader><down>", "Yp")
map("n", "<leader>j", "Yp")
map("n", "<leader><up>", "YP")
map("n", "<leader>k", "YP")

-- Move Lines
map("n", "<a-down>", "<cmd>m .+1<cr>==")
map("n", "<a-j>", "<cmd>m .+1<cr>==")
map("n", "<a-up>", "<cmd>m .-2<cr>==")
map("n", "<a-k>", "<cmd>m .-2<cr>==")

-- Move windows using the CTRL key
map("n", "<c-h>", "<C-w>h", { remap = true })
map("n", "<c-left>", "<C-w>h", { remap = true })
map("n", "<c-j>", "<C-w>j", { remap = true })
map("n", "<c-down>", "<C-w>j", { remap = true })
map("n", "<c-k>", "<C-w>k", { remap = true })
map("n", "<c-up>", "<C-w>k", { remap = true })
map("n", "<c-l>", "<C-w>l", { remap = true })
map("n", "<c-right>", "<C-w>l", { remap = true })

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>")

-- Exit vim
map("n", "<leader>qq", "<cmd>qa<cr>")

-- split Window
map("n", "<leader>ss", "<cmd>vsplit<cr>", { desc = "Split Screen horizontal" })
map("n", "<leader>sv", "<cmd>split<cr>", { desc = "Split Screen vertical" })

-- Easy way to leave terminal mode
map("t", "<esc>", "<C-\\>>C.N>")

-- Select All
map({ "i", "n" }, "<C-a>", "<esc>gg<S-v>G")
