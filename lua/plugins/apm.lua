return {
  -- Vim APM, Actions per minute, is the greatest plugin since vim-slicedbread
  -- This is still a very alpha application but should be a good time to use.
  "ThePrimeagen/vim-apm",
  lazy = false,
  config = function()
    local apm = require("vim-apm")
    apm:setup({})
    apm:toggle_monitor()
    vim.keymap.set("n", "<leader>apm", function() apm:toggle_monitor() end, { desc = "Toggle Vim APM" })
  end
}
