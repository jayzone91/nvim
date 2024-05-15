local linters = require("config").linters

return {
  -- An asynchronous linter plugin for Neovim complementary to the built-in Language Server Protocol support.
  -- https://github.com/mfussenegger/nvim-lint
  "mfussenegger/nvim-lint",
  config = function()
    local lint = require("lint")
    lint.linters_by_ft = linters

    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function() lint.try_lint() end,
    })
  end,
}
