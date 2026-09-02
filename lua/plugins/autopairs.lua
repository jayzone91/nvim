vim.pack.add({
	"https://github.com/windwp/nvim-autopairs",
})

local autopairs = require("nvim-autopairs")
local cmp = require("cmp")

autopairs.setup({
	check_ts = true,
	map_cr = true,
	map_bs = true,
	map_c_h = true,
	map_c_w = true,
	enable_check_bracket_line = true,
	enable_moveright = true,
})

cmp.event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())
