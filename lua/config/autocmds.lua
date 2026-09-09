local autocmd = vim.api.nvim_create_autocmd

local function augroup(name)
	return vim.api.nvim_create_augroup("UserConfig_" .. name, { clear = true })
end

vim.diagnostic.config({
	virtual_text = {
		current_line = true,
	},
	severity_sort = true,
	float = {
		border = "rounded",
		source = true,
	},
})

autocmd("TextYankPost", {
	group = augroup("text_yank"),
	callback = function()
		if vim.hl and vim.hl.hl_op then
			vim.hl.hl_op({
				higroup = "IncSearch",
				timeout = 150,
			})
		elseif vim.hl and vim.hl.on_yank then
			vim.hl.on_yank()
		else
			vim.highlight.on_yank({ timeout = 150 })
		end
	end,
})

autocmd("BufReadPost", {
	group = augroup("restore_last_cursor_pos"),
	callback = function(event)
		local mark = vim.api.nvim_buf_get_mark(event.buf, '"')
		local line_count = vim.api.nvim_buf_line_count(event.buf)

		if mark[1] > 0 and mark[1] <= line_count then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	group = augroup("checktime"),
	command = "checktime",
})

autocmd("VimResized", {
	group = augroup("equalize_splits"),
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})

autocmd("BufWritePre", {
	group = augroup("create_dirs"),
	callback = function(event)
		if event.match:match("^%w%w+:[\\/][\\/]") then
			return
		end

		local file = vim.uv.fs_realpath(event.match) or event.match
		local dir = vim.fn.fnamemodify(file, ":p:h")

		vim.fn.mkdir(dir, "p")
	end,
})

autocmd("LspAttach", {
	group = augroup("lsp_attach"),
	callback = function(event)
		local map = function(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, { desc = desc, buffer = event.buf })
		end

		map("n", "<F12>", vim.lsp.buf.definition, "Go to Definition")
		map("n", "<F2>", vim.lsp.buf.rename, "Rename Symbol")
		map({ "n", "x" }, "<C-.>", vim.lsp.buf.code_action, "Code Action")
		map("n", "<F8>", function()
			vim.diagnostic.jump({
				count = 1,
				float = true,
			})
		end, "Next Diagnostic")

		map("n", "<S-F8>", function()
			vim.diagnostic.jump({
				count = -1,
				float = true,
			})
		end, "Previous Diagnostic")
	end,
})

autocmd({ "CursorHold", "CursorHoldI" }, {
	group = augroup("lsp_document_highlight"),
	callback = function(event)
		for _, client in ipairs(vim.lsp.get_clients({ bufnr = event.buf })) do
			if client:supports_method("textDocument/documentHighlight") then
				vim.lsp.buf.document_highlight()
				return
			end
		end
	end,
})

autocmd({ "CursorMoved", "CursorMovedI" }, {
	group = augroup("lsp_document_highlight_clear"),
	callback = function()
		vim.lsp.buf.clear_references()
	end,
})
