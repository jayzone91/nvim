return {
  -- Soho vibes for Neovim
  -- https://github.com/rose-pine/neovim
  "rose-pine/neovim",
  name = "rose-pine",
  priority = 1000,
  opts = {
    variant = "moon",
    dark_variant = "moon",
    bold_vert_split = false,
    dim_nc_background = false,
    disable_background = true,
    disable_float_background = true,
    disable_italics = false,

    groups = {
      background = "NONE",
      background_nc = "_experimental_nc",
      panel = "surface",
      panel_nc = "base",
      border = "highlight_med",
      comment = "muted",
      link = "iris",
      puncuation = "subtle",

      error = "love",
      hint = "iris",
      info = "foam",
      warn = "gold",

      headings = {
        h1 = "iris",
        h2 = "foam",
        h3 = "rose",
        h4 = "gold",
        h5 = "pine",
        h6 = "foam",
      },
    },

    highlight_groups = {
      ColorColumn = { bg = "NONE" },
      CursorLine = { bg = "NONE", blend = 10 },
      Search = { bg = "muted", inherit = false },
      TelescopeBorder = { fg = "highlight_high", bg = "none" },
      TelescopeNormal = { bg = "none" },
      TelescopePromptNormal = { bg = "base" },
      TelescopeResultsNormal = { fg = "subtle", bg = "none" },
      TelescopeSelection = { fg = "text", bg = "base" },
      TelescopeSelectionCaret = { fg = "rose", bg = "rose" },
    },

    styles = {
      transparency = true,
    },
  },
  config = function(_, opts)
    vim.o.termguicolors = true
    require("rose-pine").setup(opts)

    vim.cmd.colorscheme("rose-pine")
  end,
}
