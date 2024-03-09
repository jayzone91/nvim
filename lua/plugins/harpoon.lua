return {
  -- Getting you where you want with the fewest keystrokes.
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local harpoon = require("harpoon")

    vim.keymap.set("n", "<leader>a", function() harpoon:list():append() end,
      { silent = true, desc = "Harpoon: Append File" })
    vim.keymap.set("n", "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
      { silent = true, desc = "Harpoon: Toggle Menu" })
    for i = 1, 4 do
      vim.keymap.set("n", "<leader>" .. i % 10, function() harpoon:list():select(i) end,
        { silent = true, desc = "Harpoon: Jump to File " .. i })
    end
  end,
}
