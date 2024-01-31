return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = vim.fn.executable("make") == 1,
    },
  },
  config = function()
    local actions = require("telescope.actions")

    require("telescope").setup({
      defaults = {
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            ["<C-x>"] = actions.delete_buffer,
          },
        },
        file_ignore_patterns = {
          "node_modules",
          "yarn.lock",
          ".git",
          ".sl",
          "_build",
          ".next",
          ".target",
        },
        hidden = true,
      },
    })

    pcall(require("telescope").load_extension, "fzf")
    local builtin = require("telescope.builtin")
    vim.keymap.set(
      "n",
      "<leader>ff",
      builtin.find_files,
      { desc = "Find Files" }
    )
    vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
    vim.keymap.set(
      "n",
      "<leader>fb",
      builtin.current_buffer_fuzzy_find,
      { desc = "Live fuzzy search inside of the currently open buffer" }
    )
    vim.keymap.set(
      "n",
      "<leader><space>",
      builtin.buffers,
      { desc = "Show all open Buffers" }
    )
  end,
}
