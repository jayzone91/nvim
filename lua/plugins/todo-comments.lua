vim.pack.add({
	"https://github.com/folke/todo-comments.nvim",
})

require("todo-comments").setup()

vim.keymap.set("n", "<leader>ft", "<cmd>TodoTrouble<cr>", { desc = "Find Todos" })
