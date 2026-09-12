return {
  "yioneko/nvim-vtsls",
  ft = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
  },
  cmd = {
    "VtsExec",
    "VtsRename",
  },
  config = function()
    require("vtsls").config({
      refactor_auto_rename = true,
    })
  end,
  keys = {
    {
      "<A-F12>",
      "<cmd>VtsExec goto_source_definition<CR>",
      desc = "Go to Source Definition",
    },
    {
      "<S-F12>",
      function()
        Snacks.picker.lsp_references()
      end,
      desc = "Find References",
    },

    {
      "<leader>co",
      "<cmd>VtsExec organize_imports<CR>",
      desc = "Organize Imports",
    },
    {
      "<leader>cm",
      "<cmd>VtsExec add_missing_imports<CR>",
      desc = "Add Missing Imports",
    },
    {
      "<leader>cu",
      "<cmd>VtsExec remove_unused_imports<CR>",
      desc = "Remove Unused Imports",
    },
    {
      "<leader>cf",
      "<cmd>VtsExec fix_all<CR>",
      desc = "Fix All",
    },
    {
      "<leader>cF",
      "<cmd>VtsExec file_references<CR>",
      desc = "File References",
    },
    {
      "<leader>cT",
      "<cmd>VtsExec goto_project_config<CR>",
      desc = "Open tsconfig",
    },
    {
      "<leader>cA",
      "<cmd>VtsExec source_actions<CR>",
      desc = "Source Actions",
    },
  },
}
