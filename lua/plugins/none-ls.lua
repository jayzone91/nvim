return {
  "nvimtools/none-ls.nvim",
  config = function()
    -- None Ls
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        -- Diagnostics
        null_ls.builtins.diagnostics.eslint_d,
        null_ls.builtins.diagnostics.markdownlint,

        -- Formatter
        null_ls.builtins.formatting.prettierd,
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.autopep8,
        null_ls.builtins.formatting.isort,
        null_ls.builtins.formatting.markdownlint,

        -- Completions
      },
    })
  end,
}
