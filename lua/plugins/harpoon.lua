return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local harpoon = require("harpoon")

    vim.keymap.set(
      "n",
      "<leader>a",
      function() harpoon:list():append() end,
      { silent = true, desc = "Appen File Harpoon" }
    )
    vim.keymap.set(
      "n",
      "<leader>h",
      function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
      { silent = true, desc = "Toggle Harpoon" }
    )

    for i = 1, 4 do
      vim.keymap.set(
        "n",
        "<leader>" .. i % 10,
        function() harpoon:list():select(i) end,
        { silent = true, desc = "Select File " .. i }
      )
    end
  end,
}
