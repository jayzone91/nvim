local autocmd = vim.api.nvim_create_autocmd

local function augroup(name)
	return vim.api.nvim_create_augroup("UserConfig_"..name, {clear = true})
end

autocmd("TextYankPost", {
	group = augroup("text_yank"),
	callback = function()
		vim.highlight.on_yank({timeout = 150})
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

autocmd({"FocusGained", "TermClose", "TermLeave"}, {
	group = augroup("checktime"),
	command = "checktime"
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
