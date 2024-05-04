return {
  -- ⚡ Smart and Powerful commenting plugin for neovim ⚡
  -- https://github.com/numToStr/Comment.nvim
  "numToStr/Comment.nvim",
  lazy = false,
  config = function()
    ---@diagnostic disable-next-line:missing-fields
    require("Comment").setup({
      pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
    })
  end,
}
