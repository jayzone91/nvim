return {
  -- Neovim treesitter plugin for setting the commentstring based on the cursor location in a file.
  -- https://github.com/JoosepAlviste/nvim-ts-context-commentstring
  "JoosepAlviste/nvim-ts-context-commentstring",
  opts = {
    enable_autocmd = false,
    languages = {
      templ = {
        __default = "// %s",
        component_declaration = "<!-- %s -->",
      },
    },
  },
}
