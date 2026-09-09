local function menu(command)
	vim.cmd(command)
end

-- Remove Neovim's default context menu
pcall(vim.cmd, "aunmenu PopUp")

-- Navigation
menu([[nnoremenu PopUp.Go\ to\ Definition <Cmd>lua vim.lsp.buf.definition()<CR>]])
menu([[nnoremenu PopUp.Show\ Diagnostics <Cmd>lua vim.diagnostic.open_float()<CR>]])

menu([[amenu PopUp.-Navigation- <Nop>]])

-- Clipboard
menu([[vnoremenu PopUp.Cut "+x]])
menu([[vnoremenu PopUp.Copy "+y]])

menu([[nnoremenu PopUp.Paste "+gP]])
menu([[vnoremenu PopUp.Paste "+P]])
menu([[inoremenu PopUp.Paste <C-r>+]])

menu([[amenu PopUp.-Clipboard- <Nop>]])

-- Selection
menu([[nnoremenu PopUp.Select\ All ggVG]])
menu([[vnoremenu PopUp.Select\ All gg0oG$]])
menu([[inoremenu PopUp.Select\ All <C-Home><C-o>VG]])
