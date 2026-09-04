vim.pack.add({
	"https://github.com/hrsh7th/nvim-cmp",
	"https://github.com/hrsh7th/cmp-nvim-lsp",
	"https://github.com/hrsh7th/cmp-buffer",
	"https://github.com/hrsh7th/cmp-path",
	"https://github.com/hrsh7th/cmp-cmdline",

	"https://github.com/garymjr/nvim-snippets",
	"https://github.com/rafamadriz/friendly-snippets",
})

require("snippets").setup({
	friendly_snippets = true,
})

local cmp = require("cmp")
local defaults = require("cmp.config.default")()
local auto_select = true

local snippet_actions = {
	snippet_forward = function()
		if vim.snippet.active({ direction = 1 }) then
			vim.schedule(function()
				vim.snippet.jump(1)
			end)
			return true
		end
	end,
	snippet_stop = function()
		if vim.snippet then
			vim.snippet.stop()
		end
	end,
}

---@param opts? {select: boolean, behavior: cmp.ConfirmBehavior}
local function confirm(opts)
	opts = vim.tbl_extend("force", {
		select = true,
		behavior = cmp.ConfirmBehavior.Insert,
	}, opts or {})

	return function(fallback)
		if cmp.core.view:visible() or vim.fn.pumvisible() == 1 then
			if cmp.confirm(opts) then
				return
			end
		end
		return fallback()
	end
end

---@param actions string[]
---@param fallback? string|fun()
local function map(actions, fallback)
	return function()
		for _, name in ipairs(actions) do
			if snippet_actions[name] then
				local ret = snippet_actions[name]()
				if ret then
					return true
				end
			end
		end
		return type(fallback) == "function" and fallback() or fallback
	end
end

vim.lsp.config("*", { capabilities = require("cmp_nvim_lsp").default_capabilities })
vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

cmp.setup({
	auto_brackets = {},
	completion = {
		completopt = "menu,menuone,noinsert" .. (auto_select and "" or ",noselect"),
	},
	snippet = {
		expand = function(item)
			local session = vim.snippet.active() and vim.snippet._session or nil

			local ok, err = pcall(vim.snippet.expand, item.body)
			if not ok then
				error("Failed to parse snippet", err)
			end

			if session then
				vim.snippet._session = session
			end
		end,
	},
	preselect = auto_select and cmp.PreselectMode.Item or cmp.PreselectMode.None,
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
		["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
		["<C-Space>"] = cmp.mapping.complete(),
		["<CR>"] = confirm({ select = auto_select }),
		["<C-y>"] = confirm({ select = true }),
		["<S-CR>"] = confirm({ behavior = cmp.ConfirmBehavior.Replace }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		["<C-CR>"] = function(fallback)
			cmp.abort()
			fallback()
		end,
		["<tab>"] = function(fallback)
			return map({ "snippet_forward", "ai_nes", "ai_accept" }, fallback)()
		end,
	}),
	sources = cmp.config.sources({
		{ name = "lazydev" },
		{ name = "nvim_lsp" },
		{ name = "path" },
		{ name = "snippets" },
	}, {
		{ name = "buffer" },
	}),
	formatting = {
		format = function(_, item)
			local icons = {}
			if icons[item.kind] then
				item.kind = icons[item.kind] .. item.kind
			end

			local widths = {
				abbr = vim.g.cmp_widths and vim.g.cmp_widths.abbr or 40,
				menu = vim.g.cmp_widths and vim.g.cmp_widths.menu or 30,
			}

			for key, width in pairs(widths) do
				if item[key] and vim.fn.strdisplaywidth(item[key]) > width then
					item[key] = vim.fn.strcharpart(item[key], 0, width - 1) .. "…"
				end
			end

			return item
		end,
	},
	experimental = {
		ghost_text = {
			hl_group = "CmpGhostText",
		},
	},
	sorting = defaults.sorting,
})
