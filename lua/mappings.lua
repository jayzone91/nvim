local map = function(mode, key, func, desc)
  return vim.keymap.set(mode, key, func, {desc = desc})
end


map("n", "<leader>qq", "<cmd>qa<cr>", "Quit Neovim")
