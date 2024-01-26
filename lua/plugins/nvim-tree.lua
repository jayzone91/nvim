return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    -- disable netrw at the very start
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- optionally enable 24-bit colour
    vim.o.termguicolors = true

    require("nvim-tree").setup({
      view = {
        width = 30,
      },
      actions = {
        open_file = {
          quit_on_open = true,
        },
      },
      renderer = {
        group_empty = true,
      },
      filters = {
        dotfiles = true,
        custom = {
          "^.DS_STORE$",
          "^\\.git$",
          "node_modules",
        },
      },
      git = {
        enable = true,
        ignore = false,
        timeout = 500,
      },
    })

    vim.keymap.set(
      "n",
      "<leader>e",
      "<Cmd>NvimTreeToggle<CR>",
      { silent = true, desc = "Open Nvimtree" }
    )
  end,
}
