vim.pack.add({
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/neovim-treesitter/treesitter-parser-registry",
})

local ts = require("nvim-treesitter")

ts.setup()

local parsers = {
	"bash",
	"blade",
	"css",
	"dockerfile",
	"go",
	"html",
	"javascript",
	"json",
	"lua",
	"markdown",
	"markdown_inline",
	"nix",
	"php",
	"python",
	"regex",
	"sql",
	"tsx",
	"typescript",
	"vim",
	"vimdoc",
	"yaml",
}

ts.install(parsers)

vim.api.nvim_create_autocmd("FileType", {
	pattern = parsers,
	callback = function()
		vim.treesitter.start()

		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})
