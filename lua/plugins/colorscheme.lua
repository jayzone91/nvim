return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      require("rose-pine").setup({
        styles = {
          bold = true,
          italic = true,
          transparency = true,
        },
        disable_background = true,
      })
      vim.cmd("colorscheme rose-pine")
      vim.cmd([[hi CursorLine guibg=#403658]])
      vim.cmd([[hi ColorColumn guibg=#26203f]])
    end,
  },
}
