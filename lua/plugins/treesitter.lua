local parser = {
  bash = { install = true, autocmd = false },
  sh = { install = false, autocmd = true },
  css = { install = true, autocmd = true },
  go = { install = true, autocmd = true },
  html = { install = true, autocmd = true },
  javascript = { install = true, autocmd = true },
  json = { install = true, autocmd = true },
  lua = { install = true, autocmd = true },
  markdown = { install = true, autocmd = true },
  markdown_inline = { install = true, autocmd = false },
  php = { install = true, autocmd = true },
  prisma = { install = true, autocmd = true },
  tsx = { install = true, autocmd = false },
  typescript = { install = true, autocmd = true },
  typescriptreact = { install = false, autocmd = true },
  vim = { install = true, autocmd = false },
  vimdoc = { install = true, autocmd = false },
  yaml = { install = true, autocmd = true },
  toml = { install = true, autocmd = true },
  powershell = { install = true, autocmd = true },
  blade = { install = true, autocmd = true },
  fish = { install = true, autocmd = true },
  just = { install = true, autocmd = true },
  make = { install = true, autocmd = true },
  nu = { install = true, autocmd = true },
  scss = { install = true, autocmd = true },
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local install = {}
      local autocmd = {}

      for name, config in pairs(parser) do
        if config.install then
          table.insert(install, name)
        end

        if config.autocmd then
          table.insert(autocmd, name)
        end
      end

      local ts = require("nvim-treesitter")

      ts.install(install)

      vim.api.nvim_create_autocmd("FileType", {
        pattern = autocmd,
        callback = function()
          vim.treesitter.start()
        end,
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPost", "BufNewFile" },
    ---@return TSContext.UserConfig
    opts = function()
      local context = require("treesitter-context")

      Snacks.toggle({
        name = "Treesitter Context",
        get = context.enabled,
        set = function(enabled)
          if enabled then
            context.enable()
          else
            context.disable()
          end
        end,
      }):map("<leader>ut")

      return {
        max_lines = 3,
      }
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("nvim-treesitter-textobjects").setup({
        select = {
          lookahead = true,
        },
        move = {
          set_jumps = true,
        },
      })

      local select = require("nvim-treesitter-textobjects.select")
      local move = require("nvim-treesitter-textobjects.move")

      vim.keymap.set({ "x", "o" }, "af", function()
        select.select_textobject("@function.outer", "textobjects")
      end, { desc = "Around Function" })

      vim.keymap.set({ "x", "o" }, "if", function()
        select.select_textobject("@function.inner", "textobjects")
      end, { desc = "Inside Function" })

      vim.keymap.set({ "x", "o" }, "aa", function()
        select.select_textobject("@parameter.outer", "textobjects")
      end, { desc = "Inside Argument" })

      vim.keymap.set({ "n", "x", "o" }, "<A-C-Down>", function()
        move.goto_next_start("@function.outer", "textobjects")
      end, { desc = "Next Function" })

      vim.keymap.set({ "n", "x", "o" }, "<A-C-Up>", function()
        move.goto_previous_start("@function.outer", "textobjects")
      end, { desc = "Previous Function" })
    end,
  },
}
