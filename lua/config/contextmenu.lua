local function menu(command)
	vim.cmd(command)
end

vim.opt.pumborder = "rounded"

vim.api.nvim_set_hl(0, "PmenuBorder", {
	link = "FloatBorder",
})

pcall(vim.cmd, [[aunmenu PopUp.How-to\ disable\ mouse]])
pcall(vim.cmd, [[aunmenu PopUp.-2-]])

-- LSP Navigation
menu([[nnoremenu PopUp.Go\ to\ References <Cmd>lua Snacks.picker.lsp_references()<CR>]])
menu([[nnoremenu PopUp.Go\ to\ Implementation <Cmd>lua Snacks.picker.lsp_implementations()<CR>]])
menu([[nnoremenu PopUp.Go\ to\ Type\ Definition <Cmd>lua Snacks.picker.lsp_type_definitions()<CR>]])

-- Diagnostics
menu([[anoremenu PopUp.-Diagnostics- <Nop>]])

menu([[nnoremenu PopUp.Show\ Diagnostics <Cmd>lua vim.diagnostic.open_float()<CR>]])
menu([[nnoremenu PopUp.Problems <Cmd>lua require("trouble").toggle("diagnostics")<CR>]])

-- Code
menu([[anoremenu PopUp.-Code- <Nop>]])

menu([[nnoremenu PopUp.Code\ Action <Cmd>lua vim.lsp.buf.code_action()<cr>]])
menu([[vnoremenu PopUp.Code\ Action <Cmd>lua vim.lsp.buf.code_action()<cr>]])

menu([[nnoremenu PopUp.Rename\ Symbol <Cmd>lua vim.lsp.buf.rename()<cr>]])

-- Formatting
menu([[anoremenu PopUp.-Format- <Nop>]])

menu([[anoremenu PopUp.Format <cmd>lua require("conform").format({lsp_format = "fallback"})<cr>]])
menu([[vnoremenu PopUp.Format <cmd>lua require("conform").format({lsp_format = "fallback"})<cr>]])

-- Git
menu([[anoremenu PopUp.-Git- <Nop>]])

menu([[nnoremenu PopUp.Preview\ Git\ Hunk <Cmd>lua require("gitsigns").preview_hunk()<CR>]])
menu([[nnoremenu PopUp.Stage\ Git\ Hunk <Cmd>lua require("gitsigns").stage_hunk()<CR>]])
menu([[nnoremenu PopUp.Reset\ Git\ Hunk <Cmd>lua require("gitsigns").reset_hunk()<CR>]])
menu([[nnoremenu PopUp.Git\ Blame <Cmd>lua require("gitsigns").blame_line({ full = true })<CR>]])
