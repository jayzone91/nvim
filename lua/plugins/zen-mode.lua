return {
  -- 🧘 Distraction-free coding for NeoVim
  -- https://github.com/folke/zen-mode.nvim
  "folke/zen-mode.nvim",
  opts = {},
  config = function()
    vim.keymap.set("n", "<leader>zz", function()
      require("zen-mode").toggle({
        window = {
          width = 0.85, -- width will be 85% of the editor width
        },
      })
    end)
  end,
}
