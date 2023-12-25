return {
  "folke/zen-mode.nvim",
  opts = {},
  config = function()
    vim.keymap.set("n", "<leader>zz", function()
      require("zen-mode").toggle({
        window = {
          width = .85
        }
      })
    end, { desc = "Toggle Zen Mode" })
  end
}
