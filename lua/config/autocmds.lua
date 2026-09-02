local group = vim.api.nvim_create_augroup("UserConfig", {
	clear = true,
})

--    ╭─────────────────────────────────────────────────────────╮
--    │                  Highlight copied text                  │
--    ╰─────────────────────────────────────────────────────────╯

vim.api.nvim_create_autocmd("TextYankPost", {
	group = group,
	callback = function()
		vim.highlight.on_yank({
			timeout = 150,
		})
	end,
})

--    ╭─────────────────────────────────────────────────────────╮
--    │             Absolute numbers in Insert mode             │
--    ╰─────────────────────────────────────────────────────────╯

vim.api.nvim_create_autocmd("InsertEnter", {
	group = group,
	callback = function()
		if vim.wo.number then
			vim.wo.relativenumber = false
		end
	end,
})

--    ╭─────────────────────────────────────────────────────────╮
--    │        Relative numbers in Normal / Visual mode         │
--    ╰─────────────────────────────────────────────────────────╯

vim.api.nvim_create_autocmd("InsertLeave", {
	group = group,
	callback = function()
		if vim.wo.number then
			vim.wo.relativenumber = true
		end
	end,
})

--    ╭─────────────────────────────────────────────────────────╮
--    │          Inactive windows use absolute numbers          │
--    ╰─────────────────────────────────────────────────────────╯

vim.api.nvim_create_autocmd({ "WinLeave", "FocusLost" }, {
	group = group,
	callback = function()
		if vim.wo.number then
			vim.wo.relativenumber = false
		end
	end,
})

vim.api.nvim_create_autocmd({ "WinEnter", "FocusGained" }, {
	group = group,
	callback = function()
		if vim.wo.number and vim.fn.mode() ~= "i" then
			vim.wo.relativenumber = true
		end
	end,
})

--    ╭─────────────────────────────────────────────────────────╮
--    │              Close utility windows with q               │
--    ╰─────────────────────────────────────────────────────────╯

vim.api.nvim_create_autocmd("FileType", {
	group = group,
	pattern = {
		"checkhealth",
		"help",
		"lspinfo",
		"man",
		"qf",
		"startuptime",
	},
	callback = function(event)
		vim.keymap.set("n", "q", "<cmd>close<cr>", {
			buffer = event.buf,
			silent = true,
			desc = "Close Window",
		})
	end,
})

--    ╭─────────────────────────────────────────────────────────╮
--    │              Restore last cursor position               │
--    ╰─────────────────────────────────────────────────────────╯

vim.api.nvim_create_autocmd("BufReadPost", {
	group = group,
	callback = function(event)
		local mark = vim.api.nvim_buf_get_mark(event.buf, '"')
		local line_count = vim.api.nvim_buf_line_count(event.buf)

		if mark[1] > 0 and mark[1] <= line_count then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

--    ╭─────────────────────────────────────────────────────────╮
--    │    Automatically reload files changed outside Neovim    │
--    ╰─────────────────────────────────────────────────────────╯

vim.api.nvim_create_autocmd({
	"FocusGained",
	"TermClose",
	"TermLeave",
}, {
	group = group,
	command = "checktime",
})

--    ╭─────────────────────────────────────────────────────────╮
--    │        Resize splits when terminal size changes         │
--    ╰─────────────────────────────────────────────────────────╯

vim.api.nvim_create_autocmd("VimResized", {
	group = group,
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})

--    ╭─────────────────────────────────────────────────────────╮
--    │     Create missing parent directories before saving     │
--    ╰─────────────────────────────────────────────────────────╯

vim.api.nvim_create_autocmd("BufWritePre", {
	group = group,
	callback = function(event)
		if event.match:match("^%w%w+://") then
			return
		end

		local dir = vim.fn.fnamemodify(event.match, ":p:h")

		if vim.fn.isdirectory(dir) == 0 then
			vim.fn.mkdir(dir, "p")
		end
	end,
})
