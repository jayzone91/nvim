return {
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },

		opts = {
			current_line_blame = false,
		},

		keys = {
			{
				"<leader>gj",
				function()
					require("gitsigns").nav_hunk("next")
				end,
				desc = "Next Git Change",
			},
			{
				"<leader>gk",
				function()
					require("gitsigns").nav_hunk("prev")
				end,
				desc = "Previous Git Change",
			},
			{
				"<leader>gp",
				function()
					require("gitsigns").preview_hunk()
				end,
				desc = "Preview Git Change",
			},
			{
				"<leader>gs",
				function()
					require("gitsigns").stage_hunk()
				end,
				desc = "Stage / Unstage Git Change",
			},
			{
				"<leader>gr",
				function()
					require("gitsigns").reset_hunk()
				end,
				desc = "Reset Git Change",
			},
			{
				"<leader>gb",
				function()
					require("gitsigns").blame_line({
						full = true,
					})
				end,
				desc = "Git Blame",
			},
			{
				"<leader>gt",
				function()
					require("gitsigns").toggle_current_line_blame()
				end,
				desc = "Toggle Line Blame",
			},
			{
				"<leader>gP",
				function()
					require("gitsigns").diffthis()
				end,
				desc = "Preview File Diff",
			},

			{
				"<leader>gs",
				function()
					require("gitsigns").stage_hunk({
						vim.fn.line("."),
						vim.fn.line("v"),
					})
				end,
				mode = "x",
				desc = "Stage / Unstage Git Change",
			},
			{
				"<leader>gr",
				function()
					require("gitsigns").reset_hunk({
						vim.fn.line("."),
						vim.fn.line("v"),
					})
				end,
				mode = "x",
				desc = "Reset Git Change",
			},
		},
	},
}
