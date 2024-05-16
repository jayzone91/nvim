return {
  "nvimdev/dashboard-nvim",
  dependencies = {
    {
      "dstein64/vim-startuptime",
      cmd = "StartupTime",
      config = function() vim.g.startuptime_tries = 10 end,
    },
  },
  lazy = true,
  event = "VimEnter",
  config = function() require("config.dashboard") end,
}
