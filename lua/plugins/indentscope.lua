return {
	"nvim-mini/mini.indentscope",
	version = "*",
	event = "VeryLazy",
	config = function()
		local indentscope = require("mini.indentscope")

		indentscope.setup({
			draw = {
				animation = indentscope.gen_animation.none(),
			},
		})
	end,
}
