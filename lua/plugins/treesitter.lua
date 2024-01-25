return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-context",
      "windwp/nvim-ts-autotag",
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = { "latex", "markdown" },
          disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats =
              pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
            if lang == "latex" then
              return true
            end
            return false
          end,
        },
        indent = {
          enable = false,
          -- disable = { "cpp", "typescript", "typescriptreact", "rust" },
        },
      })
      require("nvim-ts-autotag").setup()
      require("treesitter-context").setup({
        max_lines = 1,
      })
    end,
  },
}
