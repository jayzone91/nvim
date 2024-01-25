return {
  { "lewis6991/gitsigns.nvim", opts = {} },
  {
    "uga-rosa/ccc.nvim",
    config = function()
      require("ccc").setup({
        highlighter = {
          auto_enable = true,
          lsp = true,
        },
      })
      vim.keymap.set(
        "n",
        "<leader>ccc",
        "<cmd>CccHighlighterToggle<cr>",
        { desc = "Highlight CCC Colors" }
      )
    end,
  },
  {
    "nvim-pack/nvim-spectre",
    config = function()
      local spectre = require("spectre")
      spectre.setup()
      vim.keymap.set("n", "<leader>S", spectre.open, { desc = "Spectre" })
    end,
  },
  { "tveskag/nvim-blame-line", cmd = "EnableBlameLine", event = "BufEnter" },
  { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
}
