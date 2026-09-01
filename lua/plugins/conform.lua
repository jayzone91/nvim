vim.pack.add({
	"https://github.com/stevearc/conform.nvim",
})

local formatter = require("config.formatter").formatter

require("conform").setup({
	formatters_by_ft = formatter,
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})
