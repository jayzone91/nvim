return {
  "Exafunction/windsurf.nvim",
  main = "codeium",
  event = "InsertEnter",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    enable_chat = false,
    enable_cmp_source = false,
    virtual_text = {
      enabled = true,
      idle_delay = 100,
      map_keys = true,
      key_bindings = {
        accept = "<A-l>",
        accept_word = "<A-w>",
        accept_line = "<A-j>",
        clear = "<A-e>",
        next = "<A-]>",
        prev = "<A-[>",
      },
    },
  },
}
