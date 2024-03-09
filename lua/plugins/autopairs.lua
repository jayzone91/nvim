return {
  {
    -- A super powerful autopair plugin for Neovim that supports multiple characters.
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup()
    end,
  },
  {
    -- A super powerful autopair plugin for Neovim that supports multiple characters.
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  }
}
