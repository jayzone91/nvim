vim.pack.add({
	"https://github.com/b0o/incline.nvim",
})

local icons = require("mini.icons")

require("incline").setup({
	hide = {
		cursorline = true,
	},

	window = {
		margin = {
			horizontal = 1,
			vertical = 1,
		},
	},

	render = function(props)
		local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")

		if filename == "" then
			filename = "[No Name]"
		end

		local icon, color = icons.get("file", filename)

		return {
			{
				icon .. " ",
				group = color,
			},
			{
				filename,
				gui = vim.bo[props.buf].modified and "bold,italic" or "bold",
			},
			vim.bo[props.buf].modified and " ●" or "",
		}
	end,
})
