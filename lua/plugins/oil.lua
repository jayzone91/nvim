return {
  "stevearc/oil.nvim",
  opts = {},
  lazy = false,
  config = function()
    require("oil").setup({
      default_file_browser = true,

      columns = {
        "icons",
        "permissions",
        "size",
      },

      win_options = {
        wrap = false,
        signcolumn = "yes",
        cursorcolumn = true,
        foldcolumn = "0",
        spell = false,
        list = true,
        conceallevel = 3,
        concealcursor = "nvic",
      },

      skip_confirm_for_simple_edits = true,
      prompt_save_on_select_new_entry = false,
    })

    vim.keymap.set("n", "<leader>e", "<cmd>Oil<cr>", {desc = "Open OIL" })
  end,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
}
