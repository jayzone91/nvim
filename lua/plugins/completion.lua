return {
	"saghen/blink.cmp",
	version = "1.*",
	event = "InsertEnter",
	dependencies = {
		"rafamadriz/friendly-snippets",
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
		},
	},
}
