return {
  -- Soho vibes for Neovim
  -- https://github.com/rose-pine/neovim
  "rose-pine/neovim",
  name = "rose-pine",
  priority = 1000,
  opts = {
    variant = "moon",
    highlight_groups = {
      TelescopeBorder = { fg = "highlight_high", bg = "none" },
      TelescopeNormal = { bg = "none" },
      TelescopePromptNormal = { bg = "base" },
      TelescopeResultsNormal = { fg = "subtle", bg = "none" },
      TelescopeSelection = { fg = "text", bg = "base" },
      TelescopeSelectionCaret = { fg = "rose", bg = "rose" },
    },
  },
  config = function(_, opts)
    require("rose-pine").setup(opts)

    vim.cmd.colorscheme("rose-pine")
  end,
}
