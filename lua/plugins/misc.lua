vim.pack.add({
	"https://github.com/j-hui/fidget.nvim",
	"https://github.com/nvim-mini/mini.icons",
	"https://github.com/onsails/lspkind.nvim",
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/MunifTanjim/nui.nvim",
	"https://github.com/lewis6991/gitsigns.nvim",
})

require("fidget").setup()
require("mini.icons").setup()
require("lspkind").init()
require("gitsigns").setup()
