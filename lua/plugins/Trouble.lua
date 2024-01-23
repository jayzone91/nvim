return {
  "folke/trouble.nvim",
  lazy = true,
  event = "BufEnter",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {},
  config = function()
    local map = function(m, k, f, d)
      return vim.keymap.set(m, k, f, { desc = d })
    end

    local trouble = require("trouble")

    map("n", "<leader>xx", function()
      trouble.toggle()
    end, "Trouble")
    map("n", "<leader>xd", function()
      trouble.toggle("document_diagnostics")
    end, "Document Diag")
    map("n", "<leader>xw", function()
      trouble.toggle("workspace_diagnostics")
    end, "Workspace Diag")
    map("n", "<leader>xq", function()
      trouble.toggle("quickfix")
    end, "quickfix")
    map("n", "<leader>xl", function()
      trouble.toggle("loclist")
    end, "loclist")
    map("n", "gR", function()
      trouble.toggle("lsp_references")
    end, "lsp_references")
  end,
}
