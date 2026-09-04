vim.pack.add({
	{
		src = "https://github.com/nvim-neo-tree/neo-tree.nvim",
		version = vim.version.range("3"),
	},
})

require("neo-tree").setup({
	close_if_last_window = true,
	clipboard = {
		sync = "none",
	},
	enable_git_status = true,
	enable_diagnostics = true,
	sort_case_insensitive = false,
	event_handlers = {
		{
			event = "file_opened",
			handler = function()
				require("neo-tree.command").execute({ action = "close" })
			end,
		},
	},
	filesystem = {
		follow_current_file = { enabled = true },
		use_libuv_file_watcher = true,
	},
})

vim.keymap.set("n", "<leader>e", "<cmd>Neotree<cr>", { desc = "File Explorer" })
