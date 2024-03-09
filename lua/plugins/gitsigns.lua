return {
  -- Git integration for buffers
  "lewis6991/gitsigns.nvim",
  event = "BufEnter",
  config = function()
    require("gitsigns").setup({
      signs = {
        add          = { text = '│' },
        change       = { text = '│' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
        untracked    = { text = '┆' },
      },
      signcolumn = true,
      auto_attach = true,
    })
  end,
}
