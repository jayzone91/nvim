return {
  -- Neovim plugin to manage the file system and other tree like structures.
  -- https://github.com/nvim-neo-tree/neo-tree.nvim
  "nvim-neo-tree/neo-tree.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  cmd = "Neotree",
  keys = {
    { "<leader>e", ":Neotree reveal<CR>", { desc = "NeoTree reveal" } },
    { "\\", ":Neotree reveal position=left<CR>", { desc = "Neotree left" } },
  },
  opts = {
    window = {
      position = "float",
    },
  },
}
