return {
  {
    "folke/sidekick.nvim",
    dependencies = {
      "folke/snacks.nvim",
    },
    opts = {
      -- Codex funktioniert unabhängig von GitHub Copilot. Dessen Next Edit
      -- Suggestions können später separat ergänzt werden.
      nes = {
        enabled = false,
      },
      cli = {
        watch = true,
        win = {
          layout = "right",
          split = {
            width = 80,
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
        desc = "Codex öffnen/schließen",
      },
      {
        "<leader>af",
        function()
          require("sidekick.cli").send({ msg = "{file}" })
        end,
        desc = "Aktuelle Datei an Codex senden",
      },
      {
        "<leader>as",
        function()
          require("sidekick.cli").send({ msg = "{selection}" })
        end,
        mode = "x",
        desc = "Auswahl an Codex senden",
      },
      {
        "<leader>ap",
        function()
          require("sidekick.cli").prompt()
        end,
        mode = { "n", "x" },
        desc = "AI-Prompt auswählen",
      },
      {
        "<leader>at",
        function()
          require("config.code_actions").send_todo()
        end,
        desc = "TODO mit Codex implementieren",
      },
      {
        "<C-.>",
        function()
          require("sidekick.cli").focus({ name = "codex" })
        end,
        mode = { "n", "t", "i", "x" },
        desc = "Codex fokussieren",
      },
    },
  },
}
