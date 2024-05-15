return {
  -- A per project, auto updating and editable marks utility for fast file navigation.
  -- https://github.com/ThePrimeagen/harpoon/tree/harpoon2
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup()

    vim.keymap.set(
      "n",
      "<leader>a",
      function() harpoon:list():add() end,
      { desc = "Add File to Harpoon List" }
    )
    vim.keymap.set(
      "n",
      "<c-e>",
      function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
      { desc = "Toggle Quick Menu" }
    )

    for i = 1, 9, 1 do
      vim.keymap.set(
        "n",
        "<c-" .. i .. ">",
        function() harpoon:list():select(i) end,
        { desc = "Select File " .. i }
      )
    end

    vim.keymap.set(
      "n",
      "<leader>-",
      function() harpoon:list():prev() end,
      { desc = "Select Prev File" }
    )
    vim.keymap.set(
      "n",
      "<leader>+",
      function() harpoon:list():next() end,
      { desc = "Select Next File" }
    )
  end,
}
