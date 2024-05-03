return {
  -- Nvim Treesitter configurations and abstraction layer
  -- https://github.com/nvim-treesitter/nvim-treesitter
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  opts = {
    -- A list of parser names, or "all" (the five listed parsers should always be installed)
    ensure_installed = {
      "c",
      "lua",
      "vim",
      "vimdoc",
      "query",
    },
    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,
    -- Automatically install missing parsers when entering buffer
    auto_install = true,
    highlight = { enable = true },
    indent = { enable = true },
  },
  config = function(_, opts)
    require("nvim-treesitter.install").prefer_git = true
    require("nvim-treesitter.configs").setup(opts)
  end,
}
