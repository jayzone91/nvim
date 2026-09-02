vim.pack.add({
	"https://github.com/saghen/blink.cmp",
	"https://github.com/saghen/blink.lib",
	"https://github.com/rafamadriz/friendly-snippets",
	{ src = "https://github.com/saghen/blink.pairs", version = vim.version.range("*") },
	"https://github.com/saghen/blink.indent",
})

local cmp = require("blink.cmp")

cmp.build():pwait()

cmp.setup({
	keymap = {
		preset = "super-tab",
		["<CR>"] = { "accept", "fallback" },
	},
	completion = {
		list = {
			selection = {
				preselect = true,
				auto_insert = false,
			},
		},
		menu = {
			border = "single",
			draw = {
				components = {
					kind_icon = {
						text = function(ctx)
							if ctx.source_name ~= "Path" then
								return require("lspkind").symbol_map[ctx.kind] or "" .. ctx.icon_gap
							end

							local is_unknown_type = vim.tbl_contains(
								{ "link", "socket", "fifo", "char", "block", "unknown" },
								ctx.item.data.type
							)
							local mini_icon, _ = require("mini.icons").get(
								is_unknown_type and "os" or ctx.item.data.type,
								is_unknown_type and "" or ctx.label
							)

							return (mini_icon or ctx.kind_icon) .. ctx.icon_gap
						end,

						highlight = function(ctx)
							if ctx.source_name ~= "Path" then
								return ctx.kind_hl
							end

							local is_unknown_type = vim.tbl_contains(
								{ "link", "socket", "fifo", "char", "block", "unknown" },
								ctx.item.data.type
							)
							local mini_icon, mini_hl = require("mini.icons").get(
								is_unknown_type and "os" or ctx.item.data.type,
								is_unknown_type and "" or ctx.label
							)

							return mini_icon ~= nil and mini_hl or ctx.kind_hl
						end,
					},
				},
			},
		},
		documentation = { auto_show = true, auto_show_delay_ms = 500, window = { border = "single" } },
		ghost_text = {
			enabled = true,
		},
	},
	signature = { window = { border = "single" } },
	sources = { default = { "lsp", "path", "snippets", "buffer" } },
	fuzzy = { implementation = "rust" },
})

require("blink.pairs").download():pwait(60000)

require("blink.pairs").setup({
	highlights = {
		enabled = true,
		cmdline = true,
		groups = { "BlinkPairsOrange", "BlinkPairsPurple", "BlinkPairsBlue" },
		unmatched_group = "BlinkPairsUnmatched",
	},
})
