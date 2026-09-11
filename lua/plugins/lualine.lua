return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		options = {
			globalstatus = true,

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
					"snacks_dashboard",
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
				"encoding",
				"filetype",
			},

			lualine_y = {
				"progress",
			},

			lualine_z = {
				"location",
			},
		},

		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = {
				{
					"filename",
					path = 1,
				},
			},
			lualine_x = {
				"location",
			},
			lualine_y = {},
			lualine_z = {},
		},
	},
}
