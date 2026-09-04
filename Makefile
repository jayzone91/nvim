update:
	nvim --headless "+lua vim.pack.update()" "+TSUpdate" "+lua require('config.laravel_lsp').update()" +qa
