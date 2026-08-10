local prisma_jobs = {}

local function prisma_executable(filename)
  local root = vim.fs.root(filename, "package.json")
  if root then
    for _, executable in ipairs({ "prisma.exe", "prisma.cmd", "prisma" }) do
      local path = vim.fs.joinpath(root, "node_modules", ".bin", executable)
      if vim.fn.executable(path) == 1 then
        return path, root
      end
    end
  end
  return "prisma", root
end

local function format_prisma(bufnr)
  local filename = vim.api.nvim_buf_get_name(bufnr)
  local executable, cwd = prisma_executable(filename)

  if not cwd then
    vim.notify("Keine package.json für das Prisma-Schema gefunden", vim.log.levels.ERROR)
    return
  end
  if prisma_jobs[bufnr] then
    return
  end

  prisma_jobs[bufnr] = vim.system(
    { executable, "format", "--schema", vim.fs.dirname(filename) },
    { cwd = cwd, text = true },
    function(result)
      prisma_jobs[bufnr] = nil
      vim.schedule(function()
        if result.code ~= 0 then
          local output = result.stderr and result.stderr ~= "" and result.stderr or result.stdout
          local message = vim.trim(output or "Unbekannter Prisma-Fehler")
          vim.notify(message, vim.log.levels.ERROR, { title = "Prisma format" })
          return
        end

        if vim.api.nvim_buf_is_valid(bufnr) and not vim.bo[bufnr].modified then
          vim.api.nvim_buf_call(bufnr, function()
            vim.cmd("checktime")
          end)
        end
      end)
    end
  )
end

return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>cf",
        function()
          if vim.bo.filetype == "prisma" then
            vim.cmd.write()
            return
          end
          require("conform").format({ async = true, lsp_format = "fallback" })
        end,
        mode = { "n", "x" },
        desc = "Datei formatieren",
      },
    },
    opts = {
      formatters_by_ft = {
        css = { "prettierd", "prettier", stop_after_first = true },
        go = { "goimports", "gofumpt" },
        html = { "prettierd", "prettier", stop_after_first = true },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        javascriptreact = { "prettierd", "prettier", stop_after_first = true },
        json = { "prettierd", "prettier", stop_after_first = true },
        jsonc = { "prettierd", "prettier", stop_after_first = true },
        lua = { "stylua" },
        markdown = { "prettierd", "prettier", stop_after_first = true },
        mdx = { "prettierd", "prettier", stop_after_first = true },
        sh = { "shfmt" },
        toml = { "taplo" },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "prettierd", "prettier", stop_after_first = true },
        yaml = { "prettierd", "prettier", stop_after_first = true },
      },
      format_on_save = function(bufnr)
        if vim.bo[bufnr].filetype == "prisma" then
          return nil
        end
        return {
          timeout_ms = 1500,
          lsp_format = "fallback",
        }
      end,
    },
    config = function(_, opts)
      require("conform").setup(opts)
      vim.api.nvim_create_autocmd("BufWritePost", {
        group = vim.api.nvim_create_augroup("jay_prisma_format", { clear = true }),
        pattern = "*.prisma",
        desc = "Multi-File-Prisma-Schema formatieren",
        callback = function(event)
          format_prisma(event.buf)
        end,
      })
    end,
  },
}
