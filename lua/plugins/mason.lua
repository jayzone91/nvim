vim.pack.add({
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/mason-org/mason-lspconfig.nvim",
	"https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
})

require("mason").setup()

require("mason-lspconfig").setup({
	automatic_enable = false,
})

local lsp = require("config.lsp").lsp
local formatter = require("config.formatter").formatter

local ensure_installed = {}

local externally_managed = {
	laravel_lsp = true,
}

for x, _ in pairs(lsp) do
	if not externally_managed[x] then
		table.insert(ensure_installed, x)
	end
end

for _, x in pairs(formatter) do
	vim.list_extend(ensure_installed, x)
end

require("mason-tool-installer").setup({
	ensure_installed = ensure_installed,
	auto_update = true,
	run_on_start = true,
})
