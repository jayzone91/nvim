vim.api.nvim_create_autocmd("FileType", {
  pattern = "oil",
  callback = function() vim.opt_local.colorcolumn = "" end,
})

return {
  "stevearc/oil.nvim",
  opts = {},
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
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
    })
    vim.keymap.set(
      "n",
      "<leader>e",
      function() require("oil").toggle_float() end,
      { desc = "Toggle Oil" }
    )
  end,
}
