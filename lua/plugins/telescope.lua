return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  lazy = true,
  event = "VimEnter",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim", build = "make"},
      {"nvim-tree/nvim-web-devicons"},
  },
  config = function()
    require("config.telescope")
  end,
}
