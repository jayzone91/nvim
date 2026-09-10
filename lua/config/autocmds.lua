local autocmd = vim.api.nvim_create_autocmd

local function augroup(name)
	return vim.api.nvim_create_augroup("UserConfig_" .. name, { clear = true })
end

local hover_timer = vim.uv.new_timer()

Map_mouse_hover = function()
	local mouse = vim.fn.getmousepos()

	if mouse.winid == 0 or mouse.line == 0 then
		return
	end

	if hover_timer then
		hover_timer:stop()
	end

	if hover_timer == nil then
		return
	end

	hover_timer:start(
		500,
		0,
		vim.schedule_wrap(function()
			local current = vim.fn.getmousepos()

			if current.winid ~= mouse.winid or current.line ~= mouse.line or current.column ~= mouse.column then
				return
			end

			vim.api.nvim_set_current_win(mouse.winid)
			vim.api.nvim_win_set_cursor(mouse.winid, {
				mouse.line,
				math.max(mouse.column - 1, 0),
			})

			local diagnostics = vim.diagnostic.get(0, {
				lnum = mouse.line - 1,
			})

			if #diagnostics > 0 then
				vim.diagnostic.open_float({
					scope = "cursor",
					focusable = false,
				})
				return
			end

			vim.lsp.buf.hover({
				focusable = false,
				border = "rounded",
			})
		end)
	)
end

-- Diagnostic config
vim.diagnostic.config({
	virtual_text = {
		current_line = true,
		spacing = 2,
		prefix = function(diagnostic)
			local icons = {
				[vim.diagnostic.severity.ERROR] = " ",
				[vim.diagnostic.severity.WARN] = " ",
				[vim.diagnostic.severity.INFO] = " ",
				[vim.diagnostic.severity.HINT] = "󰌵 ",
			}

			return icons[diagnostic.severity]
		end,
	},
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.INFO] = " ",
			[vim.diagnostic.severity.HINT] = "󰌵 ",
		},
	},
	severity_sort = true,
	float = {
		border = "rounded",
		source = true,
	},
})

-- custom filetypes
vim.filetype.add({
	extension = {
		mdx = "mdx",
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
		---@diagnostic disable-next-line: deprecated
		elseif vim.hl and vim.hl.on_yank then
			---@diagnostic disable-next-line: deprecated
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

		if client:supports_method("textDocument/codeLens") then
			vim.lsp.codelens.enable(true, {
				bufnr = event.buf,
				client_id = client.id,
			})
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

		map("n", "<C-LeftMouse>", function()
			local mouse = vim.fn.getmousepos()

			if mouse.winid == 0 or mouse.line == 0 then
				return
			end

			vim.api.nvim_set_current_win(mouse.winid)
			vim.api.nvim_win_set_cursor(mouse.winid, {
				mouse.line,
				math.max(mouse.column - 1, 0),
			})

			vim.lsp.buf.definition()
		end, "Go To Definition")

		map("n", "<MouseMove>", Map_mouse_hover, "Hover")

		map("n", "<leader>cl", vim.lsp.codelens.run, "Run CodeLens")
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

autocmd("BufWritePre", {
	group = augroup("cleanup_on_save"),
	callback = function(event)
		if vim.bo[event.buf].buftype ~= "" then
			return
		end

		local view = vim.fn.winsaveview()

		vim.api.nvim_buf_call(event.buf, function()
			vim.cmd([[silent! keeppatterns %s/\s\+$//e]])
		end)

		local lines = vim.api.nvim_buf_get_lines(event.buf, 0, -1, false)

		if #lines > 0 and lines[#lines] ~= "" then
			vim.api.nvim_buf_set_lines(event.buf, -1, -1, false, { "" })
		end

		vim.fn.winrestview(view)
	end,
})
