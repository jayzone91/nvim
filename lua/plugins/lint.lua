return {
  {
    url = "https://codeberg.org/mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local lint = require("lint")
      local linter = require("config.tools").linter

      lint.linters_by_ft = linter

      vim.api.nvim_create_autocmd(
        { "BufEnter", "BufWritePost", "InsertLeave" },
        {
          callback = function()
            lint.try_lint()
          end,
        }
      )
    end,
  },
}
