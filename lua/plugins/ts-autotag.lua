return {
  "windwp/nvim-ts-autotag",
  lazy = true,
  event = "InsertEnter",
  ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  config = function()
    require("nvim-ts-autotag").setup()
  end,
}
