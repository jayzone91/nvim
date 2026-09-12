return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  ---@type NoiceConfig
  opts = {
    routes = {
      {
        filter = {
          event = "msg_show",
          find = "written",
        },
        view = "notify",
      },
      {
        filter = {
          event = "msg_show",
          find = "No signature help available",
        },
        opts = { skip = true },
      },
    },
    presets = {
      command_palette = true,
      long_message_to_split = true,
      lsp_doc_border = true,
    },
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
      },
    },
  },
}
