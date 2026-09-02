vim.pack.add({
	"https://github.com/MagicDuck/grug-far.nvim",
})

require("grug-far").setup()

vim.keymap.set({ "n", "x" }, "<leader>sr", function()
	require("grug-far").open({
		visualSelectionUsage = "auto-detect",
	})
end, { desc = "Search & Replace" })
