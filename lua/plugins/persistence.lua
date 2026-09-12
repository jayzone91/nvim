return {
  "folke/persistence.nvim",
  event = "BufReadPre",
  ---@module "persistence"
  ---@type Persistence.Config
  opts = {},
  keys = {
    {
      "<leader>qs",
      function()
        require("persistence").load()
      end,
      desc = "Restore Session",
    },
    {
      "<leader>ql",
      function()
        require("persistence").load({ last = true })
      end,
      desc = "Restore last Session",
    },
    {
      "<leader>qd",
      function()
        require("persistence").stop()
      end,
      desc = "Dont save session",
    },
  },
}
