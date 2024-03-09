return {
  -- https://codeium.com/
  -- Code AI Completion
  -- Start with ":Codeium Auth" and paste your API Token
  "Exafunction/codeium.vim",
  lazy = false,
  config = function()
    vim.keymap.set("i", "<c-g>", function() return vim.fn["codeium#Accept"]() end,
      { expr = true, silent = true }
    )
    vim.keymap.set("i", "<c-x>", function() return vim.fn["codeium#Clear"]() end,
      { expr = true, silent = true }
    )
  end,
}
