return {
	"nvim-mini/mini.map",
	version = "*",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		local map = require("mini.map")

		map.setup({
			integrations = {
				map.gen_integration.builtin_search(),
				map.gen_integration.diagnostic(),
				map.gen_integration.gitsigns(),
			},
			symbols = {
				encode = map.gen_encode_symbols.block("2x1"),
			},
		})

		map.open()
	end,
}

