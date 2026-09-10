local function menu(command)
	vim.cmd(command)
end

vim.opt.pumborder = "rounded"

vim.api.nvim_set_hl(0, "PmenuBorder", {
	link = "FloatBorder",
})

-- Remove unwanted native entries
pcall(vim.cmd, [[aunmenu PopUp.How-to\ disable\ mouse]])
pcall(vim.cmd, [[aunmenu PopUp.-2-]])

-- LSP navigation
menu([[anoremenu PopUp.Go\ to\ References <Cmd>lua Snacks.picker.lsp_references()<CR>]])
menu([[anoremenu PopUp.Go\ to\ Implementation <Cmd>lua Snacks.picker.lsp_implementations()<CR>]])
menu([[anoremenu PopUp.Go\ to\ Type\ Definition <Cmd>lua Snacks.picker.lsp_type_definitions()<CR>]])

-- Code
menu([[anoremenu PopUp.-Code- <Nop>]])

menu([[anoremenu PopUp.Code\ Action <Cmd>lua vim.lsp.buf.code_action()<CR>]])
menu([[anoremenu PopUp.Rename\ Symbol <Cmd>lua vim.lsp.buf.rename()<CR>]])

-- Formatting
menu([[anoremenu PopUp.-Format- <Nop>]])

menu([[anoremenu PopUp.Format <Cmd>lua require("conform").format({ lsp_format = "fallback" })<CR>]])

-- Diagnostics
menu([[anoremenu PopUp.-Diagnostics- <Nop>]])

menu([[anoremenu PopUp.Show\ Diagnostics <Cmd>lua vim.diagnostic.open_float()<CR>]])
menu([[anoremenu PopUp.Buffer\ Diagnostics <Cmd>lua Snacks.picker.diagnostics_buffer()<CR>]])
menu([[anoremenu PopUp.All\ Diagnostics <Cmd>lua Snacks.picker.diagnostics()<CR>]])
menu([[anoremenu PopUp.Problems <Cmd>lua require("trouble").toggle("diagnostics")<CR>]])

-- Git
menu([[anoremenu PopUp.-Git- <Nop>]])

menu([[anoremenu PopUp.Git:\ Preview\ Hunk <Cmd>lua require("gitsigns").preview_hunk()<CR>]])
menu([[anoremenu PopUp.Git:\ Stage\ Hunk <Cmd>lua require("gitsigns").stage_hunk()<CR>]])
menu([[anoremenu PopUp.Git:\ Reset\ Hunk <Cmd>lua require("gitsigns").reset_hunk()<CR>]])
menu([[anoremenu PopUp.Git:\ Blame\ Line <Cmd>lua require("gitsigns").blame_line({ full = true })<CR>]])

menu([[anoremenu PopUp.Git:\ File\ History <Cmd>lua Snacks.picker.git_log_file()<CR>]])
menu([[anoremenu PopUp.Git:\ Repository\ Log <Cmd>lua Snacks.picker.git_log()<CR>]])
menu([[anoremenu PopUp.Git:\ Status <Cmd>lua Snacks.picker.git_status()<CR>]])
menu([[anoremenu PopUp.Git:\ Diff <Cmd>lua Snacks.picker.git_diff()<CR>]])
menu([[anoremenu PopUp.Git:\ Branches <Cmd>lua Snacks.picker.git_branches()<CR>]])
menu([[anoremenu PopUp.Git:\ Stash <Cmd>lua Snacks.picker.git_stash()<CR>]])
