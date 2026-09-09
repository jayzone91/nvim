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
	},
}
