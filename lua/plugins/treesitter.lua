local parser = {
	bash = { install = true, autocmd = true },
	css = { install = true, autocmd = true },
	go = { install = true, autocmd = true },
	html = { install = true, autocmd = true },
	javascript = { install = true, autocmd = true },
	json = { install = true, autocmd = true },
	lua = { install = true, autocmd = true },
	markdown = { install = true, autocmd = true },
	markdown_inline = { install = true, autocmd = false },
	php = { install = true, autocmd = true },
	prisma = { install = true, autocmd = true },
	tsx = { install = true, autocmd = false },
	typescript = { install = true, autocmd = true },
	typescriptreact = { install = false, autocmd = true },
	vim = { install = true, autocmd = false },
	vimdoc = { install = true, autocmd = false },
	yaml = { install = true, autocmd = true },
}

return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		local install = {}
		local autocmd = {}

		for name, config in pairs(parser) do
			if config.install then
				table.insert(install, name)
			end

			if config.autocmd then
				table.insert(autocmd, name)
			end
		end

		local ts = require("nvim-treesitter")

		ts.install(install)

		vim.api.nvim_create_autocmd("FileType", {
			pattern = autocmd,
			callback = function()
				vim.treesitter.start()
			end,
		})
	end,
}
