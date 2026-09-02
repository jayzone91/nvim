vim.pack.add({
	"https://github.com/j-hui/fidget.nvim",
	"https://github.com/nvim-mini/mini.icons",
	"https://github.com/onsails/lspkind.nvim",
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/MunifTanjim/nui.nvim",
	"https://github.com/lewis6991/gitsigns.nvim",
	"https://github.com/windwp/nvim-autopairs",
})

require("fidget").setup()
require("mini.icons").setup()
require("lspkind").init()
require("gitsigns").setup()

local autopairs = require("nvim-autopairs")
local cmp = require("cmp")

autopairs.setup({
	check_ts = true,
})

cmp.event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())
