return {
  -- Lightweight yet powerful formatter plugin for NeoVim
  -- https://github.com/stevearc/conform.nvim
  "stevearc/conform.nvim",
  lazy = false,
  keys = {},
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      local disable_filetypes = { c = true, cpp = true }
      return {
        timeout_ms = 500,
        lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
      }
    end,
    formatters_by_ft = {
      lua = { "stylua" },
      javascript = { "prettierd" },
      typescript = { "prettierd" },
      javasciptreact = { "prettierd" },
      typescriptreact = { "prettierd" },
      html = { "prettierd" },
      json = { "prettierd" },
      jsonc = { "prettierd" },
      css = { "prettierd" },
      scss = { "prettierd" },
    },
  },
}
