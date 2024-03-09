return {
  "catppuccin/nvim",
  name = "catppuccin",
  event = "VeryLazy",
  config = function()
    require("catppuccin").setup({
      transparent_background = true,
      term_colors = true,
      integrations = {
        cmp = true,
        -- gitsigns = true,
        -- harpoon = true,
        mason = true,
        native_lsp = { enabled = true, },
        -- notify = true,
        -- telescope = true,
        -- treesitter = true,
        -- treesitter_context = true,
      },
    })

    vim.cmd.colorscheme("catppuccin-mocha")
    ---@diagnostic disable-next-line: param-type-mismatch
    for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
      vim.api.nvim_set_hl(0, group, {})
    end
  end,
}
