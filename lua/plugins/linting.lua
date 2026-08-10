return {
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufNewFile", "BufWritePost" },
    config = function()
      local lint = require("lint")

      lint.linters.prisma_validate = function()
        local bufnr = vim.api.nvim_get_current_buf()
        local filename = vim.api.nvim_buf_get_name(bufnr)
        local schema_dir = vim.fs.dirname(filename)
        local root = vim.fs.root(filename, "package.json")
        local command = "prisma"
        local temp_dir = vim.fn.tempname()

        vim.fn.mkdir(temp_dir, "p")
        for name, kind in vim.fs.dir(schema_dir) do
          if kind == "file" and name:match("%.prisma$") then
            local source = vim.fs.joinpath(schema_dir, name)
            local target = vim.fs.joinpath(temp_dir, name)
            local lines = vim.fs.normalize(source):lower() == vim.fs.normalize(filename):lower()
                and vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
              or vim.fn.readfile(source, "b")
            vim.fn.writefile(lines, target, "b")
          end
        end

        if root then
          for _, executable in ipairs({ "prisma.exe", "prisma.cmd", "prisma" }) do
            local path = vim.fs.joinpath(root, "node_modules", ".bin", executable)
            if vim.fn.executable(path) == 1 then
              command = path
              break
            end
          end
        end

        return {
          cmd = command,
          args = { "validate", "--schema", temp_dir },
          stdin = false,
          append_fname = false,
          stream = "both",
          ignore_exitcode = true,
          cwd = root,
          parser = function(output, bufnr, linter_cwd)
            local diagnostics = {}
            local current = vim.fs.basename(vim.api.nvim_buf_get_name(bufnr)):lower()
            local clean = output:gsub("\27%[[%d;]*m", "")

            for message, file, line in clean:gmatch("error:%s*(.-)\r?\n%s*%-%->%s*(.-%.prisma):(%d+)") do
              if vim.fs.basename(vim.fs.normalize(file)):lower() == current then
                diagnostics[#diagnostics + 1] = {
                  lnum = tonumber(line) - 1,
                  col = 0,
                  severity = vim.diagnostic.severity.ERROR,
                  source = "prisma validate",
                  message = vim.trim(message),
                }
              end
            end

            vim.fn.delete(temp_dir, "rf")
            return diagnostics
          end,
        }
      end

      lint.linters_by_ft = {
        prisma = { "prisma_validate" },
        sh = { "shellcheck" },
      }

      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
        group = vim.api.nvim_create_augroup("jay_lint", { clear = true }),
        callback = function()
          lint.try_lint()
        end,
      })

      vim.api.nvim_create_autocmd("InsertLeave", {
        group = vim.api.nvim_create_augroup("jay_prisma_lint_insert_leave", { clear = true }),
        pattern = "*.prisma",
        callback = function()
          lint.try_lint("prisma_validate")
        end,
      })
    end,
  },
}
