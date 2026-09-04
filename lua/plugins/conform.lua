vim.pack.add({
	"https://github.com/stevearc/conform.nvim",
})

local formatter = require("config.formatter").formatter

require("conform").setup({
	formatters_by_ft = formatter,
	formatters = {
		["markdown-toc"] = {
			condition = function(_, ctx)
				for _, line in ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)) do
					if line:find("<!%-%- toc %-%->") then
						return true
					end
				end
			end,
		},
		["markdown-cli2"] = {
			condition = function(_, ctx)
				local diag = vim.tbl_filter(function(d)
					return d.source == "markdownlint"
				end, vim.diagnostic.get(ctx.buf))
				return #diag > 0
			end,
		},
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})
