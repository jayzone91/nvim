return {
  "Wansmer/treesj",
  lazy = false,
  keys = {
    {
      "<leader>m",
      function()
        require("treesj").toggle()
      end,
      desc = "Split / Join",
    },
  },
  opts = {
    use_default_keymaps = false,
  },
}
