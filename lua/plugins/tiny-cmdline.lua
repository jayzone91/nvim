return {
	"rachartier/tiny-cmdline.nvim",
	lazy = false,
	init = function()
		vim.o.cmdheight = 0
		require("vim._core.ui2").enable({})
	end,
	opts = function()
		local cmdline = require("tiny-cmdline")

		return {
			on_reposition = cmdline.adapters.blink,
		}
	end,
}
