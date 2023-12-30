local map = require("utils.functions").map

return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local builtin = require("telescope.builtin")
      map("n", "<leader>ff", builtin.find_files, "Find Files")
      map("n", "<leader>fg", builtin.live_grep, "Live Grep")
      map("n", "<leader><space>", builtin.buffers, "Show open Buffers")
      map(
        "n",
        "<leader>fb",
        builtin.current_buffer_fuzzy_find,
        "Search current buffer"
      )

      -- local actions = require("telescope.actions")
      local telescope = require("telescope")
      local test, trouble = pcall(require, "trouble.providers.telescope")
      if test then
        telescope.setup({
          defaults = {
            mappings = {
              i = { ["<c-t>"] = trouble.open_with_trouble },
              n = { ["<c-t>"] = trouble.open_with_trouble },
            },
          },
        })
      end
    end,
  },
}
