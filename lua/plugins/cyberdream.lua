vim.pack.add({
	"https://github.com/scottmckendry/cyberdream.nvim",
})

require("cyberdream").setup({
	transparent = false,
	italic_comments = true,
	hide_fillchars = true,
	borderless_pickers = false,
	terminal_colors = true,
	extensions = {
		default = true,
	},
})

vim.cmd.colorscheme("cyberdream")
