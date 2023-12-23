return {
  "akinsho/toggleterm.nvim",
  verion = "*",
  config = function()
    require("toggleterm").setup({
      highlights = {
        Normal = { link = "Normal" },
        NormalNC = { link = "NormalNC" },
        NormalFloat = { link = "Normal" },
        FloatBorder = { link = "FloatBorder" },
        StatusLine = { link = "StatusLine" },
        StatusLineNC = { link = "StatusLineNC" },
        WinBar = { link = "WinBar" },
        WinBarNC = { link = "WinBarNC" },
      },
      size = 10,
      shading_factor = 2,
      direction = "float",
      float_options = {
        border = "rounded",
        highlights = { border = "Normal", background = "Normal" },
      },
    })
    vim.keymap.set("n", "<leader>t", "<cmd>ToggleTerm<cr>", { desc = "Open terminal"})
  end,
}
