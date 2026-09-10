return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		spec = {
			{ "<leader>b", group = "Buffer" },
			{ "<leader>c", group = "Code" },
			{ "<leader>f", group = "Find" },
			{ "<leader>g", group = "Git" },
			{ "<leader>w", group = "Window" },
			{ "<leader>x", group = "Problems" },
			{ "<leader>q", group = "Session / Quit" },
		},
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer keymaps",
		},
	},
}
