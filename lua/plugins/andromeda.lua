vim.pack.add({
	"https://github.com/idr4n/andromeda.nvim",
})

vim.cmd.colorscheme("andromeda")

vim.api.nvim_set_hl(0, "CmpSel", {
	link = "PmenuSel",
})
