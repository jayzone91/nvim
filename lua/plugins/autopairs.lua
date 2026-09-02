vim.pack.add({
	"https://github.com/windwp/nvim-autopairs",
})

local autopairs = require("nvim-autopairs")
local cmp = require("cmp")

autopairs.setup({
	check_ts = true,
})

cmp.event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())
