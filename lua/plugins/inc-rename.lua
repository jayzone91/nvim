vim.pack.add({
	"https://github.com/smjonas/inc-rename.nvim",
})

require("inc_rename").setup({
	input_buffer_type = "snacks",
})

vim.keymap.set("n", "<leader>rn", function()
	return ":IncRename " .. vim.fn.expand("<cword>")
end, {
	expr = true,
	desc = "Rename",
})
