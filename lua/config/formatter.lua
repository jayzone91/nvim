local M = {}

M.formatter = {
	php = { "pint" },
	blade = { "blade-formatter" },
	lua = { "stylua" },
	javascript = { "prettier" },
	typescript = { "prettier" },
	javascriptreact = { "prettier" },
	typescriptreact = { "prettier" },
	["javascript.jsx"] = { "prettier" },
	["typescript.tsx"] = { "prettier" },
	html = { "prettier" },
	css = { "prettier" },
	scss = { "prettier" },
	astro = { "prettier" },
	go = { "goimports", "gofumpt" },
	markdown = { "prettier", "markdownlint-cli2", "markdown-toc" },
	["markdown.mdx"] = { "prettier", "markdownlint-cli2", "markdown-toc" },
}

return M
