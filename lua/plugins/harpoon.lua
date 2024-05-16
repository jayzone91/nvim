return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup()

    vim.keymap.set(
      "n",
      "<leader>a",
      function() harpoon:list():add() end,
      { desc = "Add File to harpoon" }
    )
    vim.keymap.set(
      "n",
      "<c-e>",
      function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
      { desc = "Toggle Quick menu" }
    )
    vim.keymap.set(
      "n",
      "<leader>+",
      function() harpoon:list():next() end,
      { desc = "Select next file" }
    )
    vim.keymap.set(
      "n",
      "<leader>-",
      function() harpoon:list():prev() end,
      { desc = "Select prev file" }
    )

    for _, idx in ipairs({ 1, 2, 3, 4, 5 }) do
      vim.keymap.set(
        "n",
        string.format("<leader>", idx),
        function() harpoon:list():select(idx) end
      )
    end
  end,
}
