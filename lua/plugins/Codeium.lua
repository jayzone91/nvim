return {
  -- Code AI Completion
  "Exafunxtion/codeium.vim",
  config = function()
    vim.keymap.set("i", "<c-g>", function() return vim.fn["codeium#Accept"]() end,
      { expr = true, silent = true }
    )
    vim.keymap.set("i", "<c-x>", function() return vim.fn["codeium#Clear"]() end,
      { expr = true, silent = true }
    )
  end,
}
