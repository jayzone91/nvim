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
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if not client then
			return
		end

		if client:supports_method("textDocument/inlayHint") then
			vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
		end
		local map = function(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, { desc = desc, buffer = event.buf })
		end

		map("n", "<F12>", vim.lsp.buf.definition, "Go to Definition")
		map("n", "<F2>", vim.lsp.buf.rename, "Rename Symbol")
		map({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, "Code Action")
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

		map("n", "<leader>ch", function()
			local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf })
			vim.lsp.inlay_hint.enable(not enabled, { bufnr = event.buf })
		end, "Toggle Inlay Hints")
	end,
})

autocmd("CursorHold", {
	group = augroup("diagnostic_float"),
	callback = function()
		local diagnostics = vim.diagnostic.get(0, {
			lnum = vim.api.nvim_win_get_cursor(0)[1] - 1,
		})

		if #diagnostics == 0 then
			return
		end

		vim.diagnostic.open_float({
			scope = "cursor",
			focusable = false,
			close_events = {
				"BufLeave",
				"CursorMoved",
				"InsertEnter",
				"FocusLost",
			},
		})
	end,
})

---@type table<number, {token: lsp.ProgressToken, msg: string, done: boolean}[]>
local lsp_progress = vim.defaulttable()

autocmd("LspProgress", {
	group = augroup("lsp_progress"),
	callback = function(event)
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		local value = event.data.params.value

		if not client or type(value) ~= "table" then
			return
		end

		local progress = lsp_progress[client.id]

		for i = 1, #progress + 1 do
			if i == #progress + 1 or progress[i].token == event.data.params.token then
				progress[i] = {
					token = event.data.params.token,
					msg = ("[%3d%%] %s%s"):format(
						value.kind == "end" and 100 or value.percentage or 100,
						value.title or "",
						value.message and (" **%s**"):format(value.message) or ""
					),
					done = value.kind == "end",
				}

				break
			end
		end

		local messages = {}

		lsp_progress[client.id] = vim.tbl_filter(function(item)
			table.insert(messages, item.msg)
			return not item.done
		end, progress)

		local spinner = {
			"⠋",
			"⠙",
			"⠹",
			"⠸",
			"⠼",
			"⠴",
			"⠦",
			"⠧",
			"⠇",
			"⠏",
		}

		vim.notify(table.concat(messages, "\n"), vim.log.levels.INFO, {
			id = "lsp_progress_" .. client.id,
			title = client.name,
			opts = function(notification)
				notification.icon = #lsp_progress[client.id] == 0 and " "
					or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
			end,
		})
	end,
})
