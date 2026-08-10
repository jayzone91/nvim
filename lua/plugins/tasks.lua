return {
  {
    "stevearc/overseer.nvim",
    cmd = {
      "OverseerBuild",
      "OverseerClearCache",
      "OverseerInfo",
      "OverseerOpen",
      "OverseerQuickAction",
      "OverseerRun",
      "OverseerRunCmd",
      "OverseerTaskAction",
      "OverseerToggle",
    },
    keys = {
      { "<leader>rr", "<cmd>OverseerRun<cr>", desc = "Task ausführen" },
      { "<leader>rt", "<cmd>OverseerToggle<cr>", desc = "Task-Liste" },
      { "<leader>ra", "<cmd>OverseerTaskAction<cr>", desc = "Task-Aktion" },
      { "<leader>rq", "<cmd>OverseerQuickAction<cr>", desc = "Letzte Task-Aktion" },
    },
    opts = {
      templates = { "builtin", "go_modules" },
      task_list = {
        direction = "bottom",
        min_height = 12,
        max_height = 20,
      },
    },
  },
}
