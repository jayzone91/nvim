return {
	"saghen/blink.cmp",
	version = "1.*",
	event = "InsertEnter",
	dependencies = {
		"rafamadriz/friendly-snippets",
		"dsznajder/vscode-es7-javascript-react-snippets",
	},
	opts = {
		keymap = {
			preset = "enter",
			["<Tab>"] = {
				"select_next",
				"snippet_forward",
				"fallback",
			},
			["<S-Tab>"] = {
				"select_prev",
				"snippet_backward",
				"fallback",
			},
			["<Esc>"] = {
				"hide",
				"fallback",
			},
		},
		completion = {
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 300,
			},
			ghost_text = {
				enabled = true,
			},
			menu = {
				border = "rounded",
				draw = {
					padding = { 0, 1 },
					columns = {
						{ "kind_icon" },
						{ "label", "label_description", gap = 1 },
						{ "kind", gap = 1 },
					},
					compoments = {
						kind_icon = {
							text = function(ctx)
								return " " .. ctx.kind_icon .. ctx.icon_gap .. " "
							end,
							highlight = function(ctx)
								return {
									{
										group = ctx.kind_hl,
										priority = 20000,
									},
								}
							end,
						},
					},
					treesitter = { "lsp" },
				},
			},
		},
		signature = {
			enabled = true,
		},
		sources = {
			providers = {
				lsp = {
					opts = {
						tailwind_color_icon = "██",
					},
				},
			},
			snippets = {
				opts = {
					search_paths = {
						vim.fn.stdpath("data") .. "/lazy/vscode-es7-javascript-react-snippets",
					},
				},
			},
		},
	},
}
