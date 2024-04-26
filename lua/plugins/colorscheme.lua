return {
  -- You can easily change to a different colorscheme.
  -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`. (<leader>fc)
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    init = function() vim.cmd.hi("Comment gui=none") end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    init = function() vim.cmd.hi("Comment gui=none") end,
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    opts = {
      variant = "moon",
      dark_variant = "moon",
      dim_inactive_windows = true,
      extend_background_behind_borders = true,
      enable = {
        terminal = true,
        legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
        migrations = true, -- Handle deprecated options automatically
      },
      styles = {
        bold = true,
        italic = true,
        transparency = true,
      },
    },
    init = function()
      vim.cmd.colorscheme("rose-pine")
      vim.cmd.hi("Comment gui=none")
    end,
  },
}
