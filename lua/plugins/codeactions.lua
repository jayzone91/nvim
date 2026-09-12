return {
	"fnune/codeactions-on-save.nvim",
	event = "BufWritePre",
	config = function()
		local cos = require("codeactions-on-save")

		cos.register({
			"*.js",
			"*.ts",
			"*.tsx",
			"*.jsx",
		}, {
			"source.fixAll.eslint",
			"source.organizeImports",
		}, 3000)
	end,
}

