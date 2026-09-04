vim.pack.add({
	"https://github.com/folke/which-key.nvim",
})

require("which-key").setup()

local wk = require("which-key")

wk.add({
	{ "<leader>s", group = "Search" },
	{ "<leader>r", group = "Refactor" },
	{ "<leader>w", group = "Windows" },
	{ "<leader>wr", group = "Resize" },
	{ "<leader>q", group = "Quit" },
	{ "<leader>a", group = "AI" },
})
