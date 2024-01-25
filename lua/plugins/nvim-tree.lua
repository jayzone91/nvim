return {
  "kyazdani42/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = { { "nvim-tree/nvim-web-devicons" } },
  config = function()
    require("nvim-tree").setup({
      view = {
        -- side = "right",
        -- width = 40,
        float = {
          enable = true,
          open_win_config = {
            width = math.floor(vim.o.columns * 0.8),
            height = vim.o.lines - 6,
            row = 2,
            col = math.floor(vim.o.columns * 0.1),
          },
        },
      },
      actions = { open_file = { quit_on_open = true } },
      filters = { dotfiles = false, custom = { "^.DS_Store$", "^\\.git$" } },
      git = { enable = true, ignore = false, timeout = 500 },
    })

    vim.keymap.set(
      "n",
      "<leader>e",
      "<Cmd>NvimTreeToggle<CR>",
      { silent = true, desc = "Open NvimTree" }
    )
  end,
}
