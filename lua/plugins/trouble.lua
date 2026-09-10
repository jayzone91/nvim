return {
	"folke/trouble.nvim",
	cmd = "Trouble",
	keys = {
		{
			"<leader>xx",
			function()
				require("trouble").toggle("diagnostics")
			end,
			desc = "Problems",
		},
		{
			"<leader>xX",
			function()
				require("trouble").toggle({ mode = "diagnostics", filter = { buf = 0 } })
			end,
			desc = "Buffer Problems",
		},
		{
			"<leader>xq",
			function()
				require("trouble").toggle("qflist")
			end,
			desc = "Quickfix",
		},
	},
	opts = {},
}
