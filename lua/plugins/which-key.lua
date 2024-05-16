return {
  -- 💥 Create key bindings that stick. WhichKey is a lua plugin for Neovim 0.5 that displays a popup with possible keybindings of the command you started typing.
  -- https://github.com/folke/which-key.nvim
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {},
  config = function()
    vim.keymap.del("n", "<leader>")
    local wk = require("which-key")
    wk.register({
      e = {
        name = "Explorer",
      },
      c = {
        name = "Code Actions ...",
      },
      f = {
        name = "Find ...",
      },
      q = {
        name = "Quit ...",
      },
      r = {
        name = "Rename ...",
      },
      s = {
        name = "Split ...",
      },
      t = {
        name = "Toggle ...",
      },
      x = {
        name = "Trouble ...",
      },
    }, {
      prefix = "<leader>",
    })
  end,
}
