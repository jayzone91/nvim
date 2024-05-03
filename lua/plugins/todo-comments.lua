return {
  -- ✅ Highlight, list and search todo comments in your projects
  -- https://github.com/folke/todo-comments.nvim
  "folke/todo-comments.nvim",
  lazy = true,
  event = "VimEnter",
  opts = {
    signs = false,
  },
}
