return {
  "yaocccc/visual-multi.nvim",
  enabled = function()
    return vim.fn.has("nvim-0.13") == 0
  end,
  lazy = false,
  opts = {
    mappings = {
      find_next = "<C-n>",
      select_all = "<C-S-l>",

      add_cursor_up = "<C-S-Up>",
      add_cursor_down = "<C-S-Down>",

      select_left = false,
      select_right = false,
      add_cursor = false,
      add_cursor_word = false,
    },
  },
}
