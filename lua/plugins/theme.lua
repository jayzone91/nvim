return {
	"scottmckendry/cyberdream.nvim",
	lazy = false,
	priority = 1000,
	opts = {
		transparent = false,
		italic_comments = true,
		hide_fillchars = true,
		terminal_colors = true,
		cache = true,
	},
	config = function(_, opts)
		require("cyberdream").setup(opts)
		vim.cmd.colorscheme("cyberdream")

		vim.api.nvim_set_hl(0, "LspReferenceText", {
			underline = true,
		})

		vim.api.nvim_set_hl(0, "LspReferenceRead", {
			underline = true,
		})

		vim.api.nvim_set_hl(0, "LspReferenceWrite", {
			underline = true,
		})
	end,
}
