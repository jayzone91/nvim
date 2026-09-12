return {
  "stevearc/overseer.nvim",
  cmd = {
    "OverseerRun",
    "OverseerToggle",
    "OverseerTaskAction",
  },
  ---@module "overseer"
  ---@type overseer.SetupOpts
  opts = {
    task_list = {
      direction = "bottom",
    },
  },
  keys = {
    {
      "<leader>or",
      "<cmd>OverseerRun<CR>",
      desc = "Run Task",
    },
    {
      "<leader>ot",
      "<cmd>OverseerToggle<CR>",
      desc = "Toggle Tasks",
    },
    {
      "<leader>oa",
      "<cmd>OverseerTaskAction<CR>",
      desc = "Task Action",
    },
  },
}
