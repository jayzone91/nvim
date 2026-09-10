local function setup_laravel_lsp()
	local command = "laravel-ls"

	if vim.fn.executable(command) == 0 then
		vim.notify("Laravel LSP wird installiert...", vim.log.levels.INFO)

		vim.system({ "composer", "global", "require", "laravel/lsp" }, { text = true }, function(result)
			vim.schedule(function()
				if result.code ~= 0 then
					vim.notify(
						"Laravel LSP Installation fehlgeschlagen:\n" .. (result.stderr or ""),
						vim.log.levels.ERROR
					)
					return
				end

				if vim.fn.executable(command) == 0 then
					vim.notify("Laravel LSP installiert, aber laravel-ls ist nicht im PATH", vim.log.levels.WARN)
					return
				end

				vim.notify("Laravel LSP installiert.", vim.log.levels.INFO)
				vim.lsp.enable("laravel_ls")
			end)
		end)

		return
	end

	vim.lsp.enable("laravel_ls")
end

return {
	{
		"neovim/nvim-lspconfig",
		ft = { "php", "blade" },
		config = function()
			vim.lsp.config("laravel_ls", {
				cmd = { "laravel-ls" },
				filetypes = { "php", "blade" },
				root_markers = {
					"artisan",
				},
			})

			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "php", "blade" },
				callback = function(args)
					local root = vim.fs.root(args.buf, "artisan")

					if not root then
						return
					end

					setup_laravel_lsp()
				end,
			})
		end,
	},
}
