local function augroup(name)
	return vim.api.nvim_create_augroup("UserConfig_" .. name, { clear = true })
end

--    ╭─────────────────────────────────────────────────────────────╮
--    │                    Highlight copied text                    │
--    ╰─────────────────────────────────────────────────────────────╯

vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup("text_yank_post"),
	callback = function()
		vim.highlight.on_yank({
			timeout = 150,
		})
	end,
})

--    ╭─────────────────────────────────────────────────────────────╮
--    │               Absolute numbers in Insert mode               │
--    ╰─────────────────────────────────────────────────────────────╯
local group = augroup("line_numbers")

vim.api.nvim_create_autocmd("InsertEnter", {
	group = group,
	callback = function()
		if vim.wo.number then
			vim.wo.relativenumber = false
		end
	end,
})

--    ╭─────────────────────────────────────────────────────────────╮
--    │          Relative numbers in Normal / Visual mode           │
--    ╰─────────────────────────────────────────────────────────────╯

vim.api.nvim_create_autocmd("InsertLeave", {
	group = group,
	callback = function()
		if vim.wo.number then
			vim.wo.relativenumber = true
		end
	end,
})

--    ╭─────────────────────────────────────────────────────────────╮
--    │            Inactive windows use absolute numbers            │
--    ╰─────────────────────────────────────────────────────────────╯

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

--    ╭─────────────────────────────────────────────────────────────╮
--    │                Close utility windows with q                 │
--    ╰─────────────────────────────────────────────────────────────╯

vim.api.nvim_create_autocmd("FileType", {
	group = augroup("close_with_q"),
	pattern = {
		"PlenaryTestPopup",
		"checkhealth",
		"dap-float",
		"dbout",
		"gitsigns-blame",
		"grug-far",
		"help",
		"lspinfo",
		"neotest-output",
		"neotest-output-panel",
		"neotest-summary",
		"notify",
		"qf",
		"spectre_panel",
		"startuptime",
		"tsplayground",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.schedule(function()
			vim.keymap.set("n", "q", function()
				vim.cmd("close")
				pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
			end, {
				buffer = event.buf,
				silent = true,
				desc = "Quit Buffer",
			})
		end)
	end,
})

--    ╭─────────────────────────────────────────────────────────────╮
--    │    Make it easier to close man ffiles when opened inline    │
--    ╰─────────────────────────────────────────────────────────────╯

vim.api.nvim_create_autocmd("FileType", {
	group = augroup("man_unlisted"),
	pattern = { "man" },
	callback = function(event)
		vim.bo[event.buf].buflisted = false
	end,
})

--    ╭─────────────────────────────────────────────────────────────╮
--    │                Restore last cursor position                 │
--    ╰─────────────────────────────────────────────────────────────╯

vim.api.nvim_create_autocmd("BufReadPost", {
	group = augroup("restore"),
	callback = function(event)
		local mark = vim.api.nvim_buf_get_mark(event.buf, '"')
		local line_count = vim.api.nvim_buf_line_count(event.buf)

		if mark[1] > 0 and mark[1] <= line_count then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

--    ╭─────────────────────────────────────────────────────────────╮
--    │      Automatically reload files changed outside Neovim      │
--    ╰─────────────────────────────────────────────────────────────╯

vim.api.nvim_create_autocmd({
	"FocusGained",
	"TermClose",
	"TermLeave",
}, {
	group = augroup("reload"),
	command = "checktime",
})

--    ╭─────────────────────────────────────────────────────────────╮
--    │          Resize splits when terminal size changes           │
--    ╰─────────────────────────────────────────────────────────────╯

vim.api.nvim_create_autocmd("VimResized", {
	group = augroup("resize"),
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})

--    ╭─────────────────────────────────────────────────────────────╮
--    │       Create missing parent directories before saving       │
--    ╰─────────────────────────────────────────────────────────────╯

vim.api.nvim_create_autocmd("BufWritePre", {
	group = augroup("missing_directories"),
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

--    ╭─────────────────────────────────────────────────────────────╮
--    │                     Set Blade filetype                      │
--    ╰─────────────────────────────────────────────────────────────╯

vim.filetype.add({
	pattern = {
		[".*%.blade%.php"] = "blade",
	},
})
