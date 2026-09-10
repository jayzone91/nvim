local context_buf

local function open_context_menu(bufnr)
	context_buf = bufnr

	vim.cmd("buffer " .. bufnr)
	vim.cmd("popup! ]BufferLine")
end

local function setup_context_menu()
	pcall(vim.cmd, [[aunmenu ]BufferLine]])

	vim.cmd([[
    anoremenu ]BufferLine.Close
      \ <Cmd>lua Snacks.bufdelete(vim.api.nvim_get_current_buf())<CR>
  ]])

	vim.cmd([[
    anoremenu ]BufferLine.Close\ Others
      \ <Cmd>BufferLineCloseOthers<CR>
  ]])

	vim.cmd([[
    anoremenu ]BufferLine.Close\ Left
      \ <Cmd>BufferLineCloseLeft<CR>
  ]])

	vim.cmd([[
    anoremenu ]BufferLine.Close\ Right
      \ <Cmd>BufferLineCloseRight<CR>
  ]])
end

setup_context_menu()

return {
	"akinsho/bufferline.nvim",
	version = "*",
	event = "VeryLazy",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		options = {
			mode = "buffers",
			numbers = "none",
			diagnostics = "nvim_lsp",
			diagnostic_update_in_insert = false,
			separator_style = "thin",
			show_buffer_icons = true,
			show_buffer_close_icons = true,
			show_close_icon = false,
			always_show_bufferline = true,
			modified_icon = "●",
			close_command = function(bufnr)
				Snacks.bufdelete(bufnr)
			end,
			right_mouse_command = function(bufnr)
				open_context_menu(bufnr)
			end,
			offsets = {
				{
					filetype = "snacks_picker_list",
					text = "Explorer",
					text_align = "left",
					separator = true,
				},
			},
		},
	},
	keys = {
		{ "<Tab>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
		{ "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", desc = "Previous Buffer" },
		{
			"<C-w>",
			function()
				Snacks.bufdelete()
			end,
			desc = "Close Buffer",
		},
		{ "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", desc = "Close Other Buffers" },
		{ "<leader>br", "<cmd>BufferLineCloseRight<cr>", desc = "Close Buffers Right" },
		{ "<leader>bl", "<cmd>BufferLineCloseLeft<cr>", desc = "Close Buffers Left" },
	},
}
