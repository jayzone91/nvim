vim.pack.add({
	"https://github.com/NvChad/nvim-colorizer.lua",
})

require("colorizer").setup({
	filetypes = {
		"css",
		"scss",
		"html",
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
	},

	user_default_options = {
		RGB = true,
		RRGGBB = true,
		names = false,
		RRGGBBAA = true,
		AARRGGBB = true,
		mode = "background",
		tailwind = false,
	},
})
