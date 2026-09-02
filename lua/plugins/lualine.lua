vim.pack.add({
	"https://github.com/nvim-lualine/lualine.nvim",
})

require("lualine").setup({
	options = {
		theme = "auto",
		globalstatus = true,
		icons_enabled = true,
		component_separators = {
			left = "│",
			right = "│",
		},
		section_separators = {
			left = "",
			right = "",
		},
		disabled_filetypes = {
			statusline = {
				"dashboard",
				"neo-tree",
			},
		},
	},

	sections = {
		lualine_a = {
			"mode",
		},

		lualine_b = {
			"branch",
			"diff",
		},

		lualine_c = {
			{
				"filename",
				path = 1,
				symbols = {
					modified = " ●",
					readonly = " ",
					unnamed = "[No Name]",
				},
			},
		},

		lualine_x = {
			"diagnostics",
			"lsp_status",
			"filetype",
		},

		lualine_y = {
			"progress",
		},

		lualine_z = {
			"location",
		},
	},
})
