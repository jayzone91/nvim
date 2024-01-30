return {
  "j-hui/fidget.nvim",
  event = "BufEnter",
  config = function()
    require("fidget").setup({
      text = {
        spinner = "dots_negative",
      },
    })
  end,
}
