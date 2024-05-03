return {
  -- A blazing fast and easy to configure neovim statusline plugin written in pure lua.
  -- https://github.com/nvim-lualine/lualine.nvim
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VimEnter",
  config = function()
    require("lualine").setup({
      options = {
        icons_enabled = true,
        theme = "fluoromachine",
      },
      sections = {
        lualine_c = {
          "filename",
        },
      },
    })
  end,
}
