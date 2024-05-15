return {
  -- Color picker and highlighter plugin for Neovim.
  -- https://github.com/uga-rosa/ccc.nvim
  "uga-rosa/ccc.nvim",
  config = function()
    vim.o.termguicolors = true
    local ccc = require("ccc")

    ccc.setup({
      highlighter = {
        auto_enable = true,
        lsp = true,
      },
    })

    vim.keymap.set(
      "n",
      "<leader>fc",
      "<cmd>CccPick<CR>",
      { desc = "Find Colors" }
    )
  end,
}
