return {
  "yioneko/nvim-vtsls",
  ft = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
  },
  config = function()
    require("vtsls").config({
      refactor_auto_rename = true,
    })
  end,
  keys = {
    {
      "<leader>cD",
      "<cmd>VtsExec goto_source_definition<CR>",
      desc = "Go to Source Definition",
    },
    {
      "<A-F12>",
      function()
        Snacks.picker.lsp_definitions()
      end,
      desc = "Peek Definition",
    },
    {
      "<S-F12>",
      function()
        Snacks.picker.lsp_references()
      end,
      desc = "Peek References",
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
