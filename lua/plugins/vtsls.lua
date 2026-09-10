return {
	"yioneko/nvim-vtsls",
	ft = {
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
	},
	keys = {
		{
			"<leader>co",
			"<cmd>VtsExec organize_imports<CR>",
			desc = "Organize Imports",
		},
		{
			"<leader>ci",
			"<cmd>VtsExec add_missing_imports<CR>",
			desc = "Add Missing Imports",
		},
		{
			"<leader>cu",
			"<cmd>VtsExec remove_unused_imports<CR>",
			desc = "Remove Unused Imports",
		},
	},
}
