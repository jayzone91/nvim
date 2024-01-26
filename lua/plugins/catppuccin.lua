return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  lazy = false,
  config = function()
    require("catppuccin").setup({
      flavour = "mocha",
      transparent_background = true,
      show_end_of_buffer = true,
      term_colors = true,
      ---@diagnostic disable-next-line: missing-fields
      dim_inactive = {
        enable = true,
        shade = "dark",
        percentage = 0.15,
      },
      integrations = {
        mason = true,
      },
    })
    vim.cmd.colorscheme("catppuccin")
  end,
}
