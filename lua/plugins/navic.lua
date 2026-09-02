vim.pack.add({
	"https://github.com/SmiteshP/nvim-navic",
})

local navic = require("nvim-navic")

navic.setup({
	highlight = true,
	separator = "  ",
	depth_limit = 5,
	depth_limit_indicator = "…",
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(event)
		local client = vim.lsp.get_client_by_id(event.data.client_id)

		if client and client:supports_method("textDocument/documentSymbol") then
			navic.attach(client, event.buf)
		end
	end,
})

vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
