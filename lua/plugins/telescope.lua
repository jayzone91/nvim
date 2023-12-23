return {
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files, {desc = "Find Files"})
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, {desc = "Live Grep"})
      vim.keymap.set("n", "<leader>space", builtin.buffers, {desc = "Show open Buffers"})
      vim.keymap.set("n", "<leader>fb", builtin.current_buffer_fuzzy_find, {desc = "Search current buffer"})
    end,
  },
}
