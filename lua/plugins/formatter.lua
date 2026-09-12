return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  cmd = "ConformInfo",
  ---@module "conform"
  ---@type conform.setupOpts
  opts = {
    formatters_by_ft = require("config.tools").formatter,
    formatters = {
      ["markdown-toc"] = {
        condition = function(_, ctx)
          for _, line in
            ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false))
          do
            if line:find("<!%-%- toc %-%->") then
              return true
            end
          end
          return false
        end,
      },
      ["markdownlint-cli2"] = {
        condition = function(_, ctx)
          local diag = vim.tbl_filter(function(d)
            return d.source == "markdownlint"
          end, vim.diagnostic.get(ctx.buf))
          return #diag > 0
        end,
      },
    },
    default_format_opts = {
      lsp_format = "fallback",
    },
    format_on_save = {
      timeout_ms = 3000,
    },
  },
}
