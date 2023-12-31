return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {},
  config = function()
    local wk = require("which-key")
    wk.register({
      ["<leader>w"] = {
        "<cmd>WhichKey<cr>",
        "Show all Keybinds",
      },
      ["<leader>"] = {
        c = {
          name = "CodeActions",
        },
        d = {
          name = "Format",
        },
        f = {
          name = "+Telescope",
        },
        q = {
          name = "+QUIT",
        },
        s = {
          name = "+Splits",
        },
        x = {
          name = "+Trouble",
        },
        z = {
          name = "+zen",
        },
      },
    })
  end,
}
