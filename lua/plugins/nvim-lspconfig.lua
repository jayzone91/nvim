vim.pack.add({
	{ src = "https://github.com/neovim/nvim-lspconfig" },
})

local capabilities = vim.lsp.protocol.make_client_capabilities()

if pcall(require, "cmp_nvim_lsp") then
	capabilities = vim.tbl_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
end

if pcall(require, "blink.cmp") then
	capabilities = vim.tbl_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities({}, false))
end

local on_attach = function() end

for server, config in pairs(require("config.lsp").lsp) do
	config = config or {}

	config = vim.tbl_deep_extend("force", {
		capabilities = capabilities,
		on_attach = on_attach,
	}, config)

	vim.lsp.config(server, config)
	vim.lsp.enable(server)
end

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
	callback = function(event)
		local map = function(keys, func, desc, mode)
			mode = mode or "n"
			vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		map("rn", vim.lsp.buf.rename, "Rename")
		map("<leader>ca", vim.lsp.buf.code_action, "Code Actions")
		map("gD", vim.lsp.buf.declaration, "Declaration")

		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client and client:supports_method("textDocument/documentHighlight", event.buf) then
			local highlight_group = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = event.buf,
				group = highlight_group,
				callback = vim.lsp.buf.document_highlight,
			})

			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = event.buf,
				group = highlight_group,
				callback = vim.lsp.buf.clear_references,
			})

			vim.api.nvim_create_autocmd("LspDetach", {
				group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
				callback = function(event2)
					vim.lsp.buf.clear_references()
					vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
				end,
			})
		end

		if client and client:supports_method("textDocument/inlayHint", event.buf) then
			map("<leader>th", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ buffer = event.buf }))
			end, "Toggle Inlay Hints")
		end

		if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlineCompletion, event.buf) then
			local function inline_completion(method)
				return function()
					vim.lsp.inline_completion.enable(true, { bufnr = event.buf })
					return vim.lsp.inline_completion[method]()
				end
			end

			map("<C-F>", inline_completion("get"), "accept inline completion", "i")
			map("<C-G>", inline_completion("select"), "switch inline completion", "i")
		end
	end,
})
