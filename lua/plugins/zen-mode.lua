return {
  "folke/zen-mode.nvim",
  opts = {},
  config = function()
    vim.keymap.set("n", "<leader>zz", function()
      require("zen-mode").toggle({
        window = {
          width = .85
        }
      }, { desc = "Toggle Zen Mode" })
    end)
  end
}
