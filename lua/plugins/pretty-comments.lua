vim.pack.add({
	"https://github.com/Cartoone9/pretty-comment.nvim",
})

require("pretty-comment").setup()

--    ╭────────────────────────────╮
--    │          Keymaps           │
--    ╰────────────────────────────╯

vim.keymap.set("x", "gcb", ":CommentBox<Cr>", { silent = true, desc = "Comment Box" })
vim.keymap.set("n", "gcb", "<cmd>CommentBox<CR>", { silent = true, desc = "Comment Box" })
vim.keymap.set("n", "gce", "<cmd>CommentEqualize<cr>", { silent = true, desc = "Equalize all Comments" })
vim.keymap.set("x", "gcc", function()
	return require("vim._comment").operator()
end, { expr = true, desc = "Comment toggle (instant, avoids gc delay)" })
