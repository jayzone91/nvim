return {
  -- A blazing fast and easy to configure neovim statusline
  -- plugin written in pure lua.
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = {
    -- If you want to have icons in your statusline choose one of these
    "nvim-tree/nvim-web-devicons",
    -- You'll also need to have a patched font if you want icons.
  },
  config = function()
    require("lualine").setup({
      options = {
        theme = "catppuccin",
        globalstatus = true,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
      },
      -- Lualine has sections as shown below.
      --[[
      -- +-------------------------------------------------+
      -- | A | B | C                             X | Y | Z |
      -- +-------------------------------------------------+
      --]]
      -- Each sections holds its components e.g. Vim's current mode.
      sections = {
        lualine_b = {
          { "branch", icon = "" },
          "diff",
          "diagnostics",
        },
        lualine_c = {
          { "filename", path = 1 },
        },
        lualine_x = {
          "filetype",
        },
      },
    })
  end,
}
