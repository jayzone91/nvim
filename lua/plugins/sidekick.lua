return {
  "folke/sidekick.nvim",
  opts = {
    nes = {
      enabled = false,
    },
    cli = {
      win = {
        keys = {
          stopinsert = {
            "<Esc>",
            "stopinsert",
            mode = "t",
            desc = "Normal Mode",
          },
        },
      },
    },
  },
  keys = {
    {
      "<leader>ac",
      function()
        require("sidekick.cli").toggle({ name = "codex", focus = true })
      end,
      desc = "Codex",
    },
    {
      "<leader>at",
      function()
        require("sidekick.cli").send({ msg = "{this}" })
      end,
      desc = "Send Context",
      mode = { "n", "x" },
    },
    {
      "<leader>af",
      function()
        require("sidekick.cli").send({ msg = "{file}" })
      end,
      desc = "Send File",
    },
    {
      "<leader>av",
      function()
        require("sidekick.cli").send({ msg = "{selection}" })
      end,
      desc = "Send Selection",
      mode = "x",
    },
    {
      "<leader>ap",
      function()
        require("sidekick.cli").prompt()
      end,
      mode = { "n", "x" },
      desc = "AI Prompt",
    },
  },
}
