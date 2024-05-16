return {
  "hrsh7th/nvim-cmp",
  lazy = true,
  event = "InsertEnter",
  priority = 100,
  dependencies = {
    "onsails/lspkind.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-buffer",
    {
      "L3MON4D3/LuaSnip",
      build = "make install_jsregexp",
    },
    "saadparwaiz1/cmp_luasnip",
    {
      "rafamadriz/friendly-snippets",
      config = function() require("luasnip.loaders.from_vscode").lazy_load() end,
    },
  },
  config = function() require("config.cmp") end,
}
