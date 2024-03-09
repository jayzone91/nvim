vim.api.nvim_create_autocmd("FileType", {
  pattern = "oil",
  callback = function() vim.opt_local.colorcolumn = "" end,
})

return {
  "stevearc/oil.nvim",
  opts = {},
  lazy = false,
  config = function()
    require("oil").setup({
      keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<C-\\>"] = "actions.select_vsplit",
        ["<C-enter>"] = "actions.select_split", -- this is used to navigate left
        ["<C-t>"] = "actions.select_tab",
        ["<C-p>"] = "actions.preview",
        ["q"] = "actions.close",
        ["<C-r>"] = "actions.refresh",
        ["<BS>"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["~"] = "actions.tcd",
        ["gs"] = "actions.change_sort",
        ["gx"] = "actions.open_external",
        ["H"] = "actions.toggle_hidden",
      },
      use_default_keymaps = false,
      default_file_browser = true,

      columns = {
        "icons",
        --       "permissions",
        "size",
      },

      win_options = {
        wrap = false,
        signcolumn = "no",
        cursorcolumn = false,
        foldcolumn = "0",
        spell = false,
        list = true,
        conceallevel = 3,
        concealcursor = "nvic",
      },

      skip_confirm_for_simple_edits = true,
      prompt_save_on_select_new_entry = false,
    })

    vim.keymap.set("n", "<leader>e", "<cmd>Oil<cr>", { desc = "Open OIL" })
  end,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
}
