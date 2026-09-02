vim.pack.add({
	"https://github.com/folke/snacks.nvim",
})

require("snacks").setup({
	animate = { enabled = false },
	bigfile = { enabled = true },
	bufdelete = { enabled = true },
	dashboard = {
		enabled = true,
		sections = {
			{ section = "header" },
			{ section = "keys", gap = 1, padding = 1 },
			{
				pane = 2,
				icon = " ",
				desc = "Browse Repo",
				padding = 1,
				key = "b",
				action = function()
					Snacks.gitbrowse()
				end,
			},
			function()
				local in_git = Snacks.git.get_root() ~= nil
				local cmds = {
					{
						title = "Notifications",
						cmd = "gh notify -s -a -n5",
						action = function()
							vim.ui.open("https://github.com/notifications")
						end,
						key = "n",
						icon = " ",
						height = 5,
						enabled = true,
					},
					{
						title = "Open Issues",
						cmd = "gh issue list -L 3",
						key = "i",
						action = function()
							vim.fn.jobstart("gh issue list --web", { detach = true })
						end,
						icon = " ",
						height = 7,
					},
					{
						icon = " ",
						title = "Open PRs",
						cmd = "gh pr list -L 3",
						key = "P",
						action = function()
							vim.fn.jobstart("gh pr list --web", { detach = true })
						end,
						height = 7,
					},
					{
						icon = " ",
						title = "Git Status",
						cmd = "git --no-pager diff --stat -B -M -C",
						height = 10,
					},
				}
				return vim.tbl_map(function(cmd)
					return vim.tbl_extend("force", {
						pane = 2,
						section = "terminal",
						enabled = in_git,
						padding = 1,
						ttl = 5 * 60,
						indent = 3,
					}, cmd)
				end, cmds)
			end,
		},
		presets = {
			keys = {
				{ icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
				{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
				{ icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
				{ icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
				{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
			},
		},
	},
	debug = { enabled = false },
	dim = { enabled = false },
	explorer = { enabled = false },
	gh = { enabled = true },
	git = { enabled = true },
	gitbrowse = { enabled = false },
	image = { enabled = false },
	indent = { enabled = true },
	input = { enabled = true, win = { input = { bo = { autocomplete = false } } } },
	keymap = { enabled = true },
	layout = { enabled = false },
	lazygit = { enabled = false },
	notifier = { enabled = true, timeout = 3000 },
	notify = { enabled = true },
	picker = { enabled = true, win = { input = { bo = { autocomplete = false } } } },
	profiler = { enabled = true },
	quickfile = { enabled = false },
	rename = { enabled = true },
	scope = { enabled = false },
	scroll = { enabled = false },
	statuscolumn = { enabled = true },
	terminal = { enabled = false },
	toggle = { enabled = true },
	util = { enabled = true },
	win = { enabled = true },
	words = { enabled = false },
	zen = { enabled = false },

	styles = {
		notification = {
			wo = { wrap = true },
		},
	},
})

vim.keymap.set("n", "<leader><space>", function()
	Snacks.picker.buffers()
end, { desc = "Buffers" })
vim.keymap.set("n", "<leader>ff", function()
	Snacks.picker.files()
end, { desc = "Find Files" })
vim.keymap.set("n", "<leader>fg", function()
	Snacks.picker.grep()
end, { desc = "Live Grep" })
vim.keymap.set("n", "<leader>fr", function()
	Snacks.picker.recent()
end, { desc = "Search Recent Files" })

-- LSP
vim.keymap.set("n", "gd", function()
	Snacks.picker.lsp_definitions()
end, { desc = "Goto Definition" })
vim.keymap.set("n", "gD", function()
	Snacks.picker.lsp_declarations()
end, { desc = "Goto Declaration" })
vim.keymap.set("n", "gr", function()
	Snacks.picker.lsp_references()
end, { desc = "Goto References" })
vim.keymap.set("n", "gI", function()
	Snacks.picker.lsp_implementations()
end, { desc = "Goto Implementations" })
vim.keymap.set("n", "gy", function()
	Snacks.picker.lsp_type_definitions()
end, { desc = "Goto Type Definition" })
