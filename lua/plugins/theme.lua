return {
  "rose-pine/neovim",
  name = "rose-pine",
  lazy = false,
  priority = 1000,
  opts = {
    dim_inactive_windows = false,
    styles = {
      transparency = true,
    },
    highlight_groups = {
      LspInlayHint = { bg = "base", fg = "muted", italic = true },
      NotificationInfo = { bg = "none", fg = "text" },
      NotificationWarning = { bg = "none", fg = "subtle" },
      NotificationError = { bg = "none", fg = "love" },
    },
  },
  config = function(_, opts)
    require("rose-pine").setup(opts)

    vim.cmd.colorscheme("rose-pine")
  end,
}
