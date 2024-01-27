return {
  -- Calculate your Motion APM.
  "ThePrimeagen/vim-apm",
  enabled = true,
  config = function()
    local apm = require("vim-apm")
    apm:setup({})
    -- Start APM immediately
    apm:toggle_monitor()
    vim.keymap.set(
      "n",
      "<leader>apm",
      function() apm:toggle_monitor() end,
      { desc = "Toggle VIM APM" }
    )
  end,
}
