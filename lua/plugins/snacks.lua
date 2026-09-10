return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		bigfile = { enabled = true },
		explorer = { enabled = true, replace_netrw = true },
		input = { enabled = true },
		notifier = { enabled = true, timeout = 3000 },
		picker = {
			enabled = true,
			ui_select = true,
			sources = {
				explorer = {
					layout = {
						preset = "sidebar",
						layout = {
							position = "left",
							width = 32,
						},
					},
					auto_close = false,
					follow_file = true,
					tree = true,
					hidden = true,
					ignored = false,
					win = {
						list = {
							keys = {
								["<CR>"] = "confirm",
								["<leader>h"] = "edit_split",
								["<leader>v"] = "edit_vsplit",
							},
						},
					},
				},
			},
		},
		quickfile = { enabled = true },
		rename = { enabled = true },
		terminal = { enabled = true },
		words = { enabled = true },
	},
	keys = {
		{
			"<C-p>",
			function()
				Snacks.picker.files()
			end,
			desc = "Quick Open",
		},
		{
			"<leader>ff",
			function()
				Snacks.picker.files()
			end,
			desc = "Search Files",
		},
		{
			"<C-S-p>",
			function()
				Snacks.picker.commands()
			end,
			desc = "Command Palette",
		},
		{
			"<C-S-f>",
			function()
				Snacks.picker.grep()
			end,
			desc = "Search in Files",
		},
		{
			"<leader>fg",
			function()
				Snacks.picker.grep()
			end,
			desc = "Live Grep",
		},
		{
			"<leader>t",
			function()
				Snacks.terminal()
			end,
			desc = "Terminal",
		},
		{
			"<leader>fr",
			function()
				Snacks.picker.recent()
			end,
			desc = "Recent Files",
		},
		{
			"<leader>fb",
			function()
				Snacks.picker.buffers()
			end,
			desc = "Open Buffers",
		},
		{
			"<leader><space>",
			function()
				Snacks.picker.buffers()
			end,
			desc = "Open Buffers",
		},
		{
			"<C-b>",
			function()
				Snacks.explorer()
			end,
			desc = "Explorer",
		},
		{
			"<leader>e",
			function()
				Snacks.explorer()
			end,
			desc = "Explorer",
		},
		{
			"<leader>cr",
			function()
				Snacks.picker.lsp_references()
			end,
			desc = "References",
		},
		{
			"<leader>cd",
			function()
				Snacks.picker.lsp_definitions()
			end,
			desc = "Definitions",
		},
		{
			"<leader>ci",
			function()
				Snacks.picker.lsp_implementations()
			end,
			desc = "Implementations",
		},
		{
			"<leader>ct",
			function()
				Snacks.picker.lsp_type_definitions()
			end,
			desc = "Type Definitions",
		},
		{
			"<leader>cs",
			function()
				Snacks.picker.lsp_symbols()
			end,
			desc = "Document Symbols",
		},
		{
			"<leader>cS",
			function()
				Snacks.picker.lsp_workspace_symbols()
			end,
			desc = "Workspace Symbols",
		},
		{
			"<A-n>",
			function()
				Snacks.words.jump(vim.v.count1)
			end,
			desc = "Next Reference",
		},
		{
			"<A-p>",
			function()
				Snacks.words.jump(-vim.v.count1)
			end,
			desc = "Previous Reference",
		},
		{
			"<leader>xd",
			function()
				Snacks.picker.diagnostics()
			end,
			desc = "Diagnostics",
		},
		{
			"<leader>xD",
			function()
				Snacks.picker.diagnostics_buffer()
			end,
			desc = "Buffer Diagnostics",
		},
		{
			"<leader>gB",
			function()
				Snacks.picker.git_branches()
			end,
			desc = "Git Branches",
		},
		{
			"<leader>gL",
			function()
				Snacks.picker.git_log()
			end,
			desc = "Git Log",
		},
		{
			"<leader>gF",
			function()
				Snacks.picker.git_log_file()
			end,
			desc = "Git File History",
		},
		{
			"<leader>gS",
			function()
				Snacks.picker.git_status()
			end,
			desc = "Git Status",
		},
		{
			"<leader>gD",
			function()
				Snacks.picker.git_diff()
			end,
			desc = "Git Diff",
		},
		{
			"<leader>gT",
			function()
				Snacks.picker.git_stash()
			end,
			desc = "Git Stash",
		},
	},
}
