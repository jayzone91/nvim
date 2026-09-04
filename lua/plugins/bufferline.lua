vim.pack.add({
	"https://github.com/akinsho/bufferline.nvim",
})

require("bufferline").setup({
	options = {
		close_command = function(n)
			Snacks.bufdelete(n)
		end,
		right_mouse_command = function(n)
			Snacks.bufdelete(n)
		end,
		diagnostics = "nvim_lsp",
		always_show_bufferline = false,
		offsets = {
			{
				filetype = "neo-tree",
				text = "Neo-tree",
				highlight = "Directory",
				text_align = "left",
			},
			{
				filetype = "snacks_layout_box",
			},
		},
	},
})

vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
	callback = function()
		vim.schedule(function()
			pcall(nvim_bufferline)
		end)
	end,
})
