return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  config = function()
    local harpoon = require("harpoon")

    local function sync(evt, list)
      local file = evt.file

      local thing = vim.api.nvim_win_get_cursor(0)
      local r, c = thing[1], thing[2]

      for _, item in pairs(list.items) do
        local relative = vim.loop.cwd() .. "/" .. item.value
        if relative == file then
          item.context = {
            col = c,
            row = r,
          }
        end
      end
    end

    harpoon:setup({
      default = {
        save_on_toggle = true,
        sync_on_ui_close = true,
        BufLeave = sync,
        VimLeavePre = sync,
      },
    })

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

    for i = 1, 10 do
      vim.keymap.set(
        "n",
        "<leader>" .. i % 10,
        function() harpoon:list():select(i) end,
        { silent = true, desc = "Select File " .. i }
      )
    end
  end,
}
