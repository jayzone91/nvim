vim.pack.add({
	"https://github.com/hrsh7th/nvim-cmp",
	"https://github.com/hrsh7th/cmp-nvim-lsp",
	"https://github.com/hrsh7th/cmp-buffer",
	"https://github.com/hrsh7th/cmp-path",
	"https://github.com/hrsh7th/cmp-cmdline",

	"https://github.com/L3MON4D3/LuaSnip",
	"https://github.com/saadparwaiz1/cmp_luasnip",
	"https://github.com/rafamadriz/friendly-snippets",

	"https://github.com/onsails/lspkind.nvim",
})

local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require("lspkind")
local mini_icons = require("mini.icons")

require("luasnip.loaders.from_vscode").lazy_load()

local function has_words_before()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))

	if col == 0 then
		return false
	end

	return vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local source_names = {
	nvim_lsp = "[LSP]",
	luasnip = "[Snippet]",
	buffer = "[Buffer]",
	path = "[Path]",
}

cmp.setup({
	enabled = function()
		return vim.bo.buftype ~= "prompt"
	end,

	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},

	completion = {
		autocomplete = {
			cmp.TriggerEvent.TextChanged,
		},
		completeopt = "menu,menuone,noselect",
		keyword_length = 1,
	},

	preselect = cmp.PreselectMode.None,

	view = {
		docs = {
			auto_open = true,
		},
		entries = {
			name = "custom",
			selection_order = "top_down",
			follow_cursor = true,
		},
	},

	window = {
		completion = cmp.config.window.bordered({
			border = "rounded",
			winhighlight = "Normal:CmpPmenu,FloatBorder:CmpBorder,CursorLine:CmpSel,Search:None",
			scrollbar = true,
			side_padding = 1,
			max_height = 15,
		}),

		documentation = cmp.config.window.bordered({
			border = "rounded",
			winhighlight = "Normal:CmpDoc,FloatBorder:CmpDocBorder",
			max_width = 80,
			max_height = 20,
		}),
	},

	formatting = {
		fields = { "kind", "abbr", "menu" },

		format = function(entry, vim_item)
			local completion_item = entry:get_completion_item()

			if entry.source.name == "path" then
				local label = completion_item.label or vim_item.abbr
				local icon = mini_icons.get("file", label)

				vim_item.kind = icon
			else
				local kind = vim_item.kind
				local icon = lspkind.symbol_map[kind]

				if not icon then
					icon = mini_icons.get("lsp", kind)
				end

				vim_item.kind = icon or ""
			end

			vim_item.menu = source_names[entry.source.name] or ("[" .. entry.source.name .. "]")

			if #vim_item.abbr > 50 then
				vim_item.abbr = vim_item.abbr:sub(1, 47) .. "..."
			end

			return vim_item
		end,
	},

	mapping = cmp.mapping.preset.insert({
		["<Down>"] = cmp.mapping.select_next_item({
			behavior = cmp.SelectBehavior.Select,
		}),

		["<Up>"] = cmp.mapping.select_prev_item({
			behavior = cmp.SelectBehavior.Select,
		}),

		["<C-n>"] = cmp.mapping.select_next_item({
			behavior = cmp.SelectBehavior.Select,
		}),

		["<C-p>"] = cmp.mapping.select_prev_item({
			behavior = cmp.SelectBehavior.Select,
		}),

		["<C-Space>"] = cmp.mapping.complete(),

		["<C-e>"] = cmp.mapping.abort(),

		["<C-d>"] = cmp.mapping.scroll_docs(4),
		["<C-u>"] = cmp.mapping.scroll_docs(-4),

		["<CR>"] = cmp.mapping(function(fallback)
			if cmp.visible() and cmp.get_selected_entry() then
				cmp.confirm({
					behavior = cmp.ConfirmBehavior.Replace,
					select = false,
				})
			else
				fallback()
			end
		end, { "i", "s" }),

		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				local entry = cmp.get_selected_entry()

				if entry then
					cmp.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = false,
					})
				else
					cmp.select_next_item({
						behavior = cmp.SelectBehavior.Select,
					})

					cmp.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = false,
					})
				end
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item({
					behavior = cmp.SelectBehavior.Select,
				})
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),

	sources = cmp.config.sources({
		{
			name = "nvim_lsp",
			priority = 1000,
		},
		{
			name = "luasnip",
			priority = 750,
		},
		{
			name = "path",
			priority = 500,
		},
	}, {
		{
			name = "buffer",
			priority = 250,
			keyword_length = 3,
		},
	}),

	experimental = {
		ghost_text = {
			hl_group = "Comment",
		},
	},

	sorting = {
		priority_weight = 2,

		comparators = {
			cmp.config.compare.offset,
			cmp.config.compare.exact,
			cmp.config.compare.score,
			cmp.config.compare.recently_used,
			cmp.config.compare.locality,
			cmp.config.compare.kind,
			cmp.config.compare.sort_text,
			cmp.config.compare.length,
			cmp.config.compare.order,
		},
	},
})

cmp.setup.cmdline("/", {
	mapping = cmp.mapping.preset.cmdline(),

	sources = {
		{
			name = "buffer",
		},
	},
})

cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),

	sources = cmp.config.sources({
		{
			name = "path",
		},
	}, {
		{
			name = "cmdline",
		},
	}),
})
