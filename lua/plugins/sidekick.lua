vim.pack.add({
	"https://github.com/folke/sidekick.nvim",
})

require("sidekick").setup({
	nes = {
		enabled = false,
	},
	cli = {
		win = {
			layout = "right",
			split = {
				width = 80,
			},
		},
	},
})

local cli = require("sidekick.cli")

vim.keymap.set("n", "<leader>aa", function()
	cli.toggle({ name = "codex", focus = true })
end, { desc = "Codex Toggle" })

vim.keymap.set("n", "<leader>af", function()
	cli.send({ msg = "{this}" })
end, { desc = "Codex Send This" })

vim.keymap.set("n", "<leader>af", function()
	cli.send({ msg = "{file}" })
end, { desc = "Codex Send File" })

vim.keymap.set("n", "<leader>av", function()
	cli.send({ msg = "{selection}" })
end, { desc = "Codex send Selection" })

vim.keymap.set({ "n", "x" }, "<leader>ap", function()
	cli.prompt()
end, { desc = "Codex Propmpt" })
