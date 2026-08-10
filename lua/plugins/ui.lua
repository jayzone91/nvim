return {
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
    opts = {},
  },
  {
    "akinsho/bufferline.nvim",
    version = "*",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Vorheriger Buffer" },
      { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Nächster Buffer" },
      { "<leader>bd", "<cmd>bdelete<cr>", desc = "Buffer schließen" },
    },
    opts = {
      options = {
        mode = "buffers",
        numbers = "none",
        close_command = "bdelete! %d",
        right_mouse_command = "bdelete! %d",
        indicator = { style = "none" },
        separator_style = "thin",
        show_buffer_close_icons = true,
        show_close_icon = false,
        always_show_bufferline = false,
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level)
          local icon = level:match("error") and " " or " "
          return " " .. icon .. count
        end,
        offsets = {
          {
            filetype = "snacks_picker_list",
            text = "EXPLORER",
            text_align = "left",
            separator = true,
          },
        },
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "auto",
        globalstatus = true,
        section_separators = "",
        component_separators = "│",
        disabled_filetypes = {
          statusline = { "snacks_picker_list", "snacks_picker_input", "snacks_picker_preview" },
        },
      },
      sections = {
        lualine_a = { { "mode", fmt = function(mode) return mode:sub(1, 1) end } },
        lualine_b = { "branch", "diff" },
        lualine_c = { { "filename", path = 1, symbols = { modified = " ●", readonly = " " } } },
        lualine_x = { "diagnostics", "filetype" },
        lualine_y = { "encoding", "fileformat" },
        lualine_z = { "location" },
      },
      extensions = { "lazy", "man", "quickfix", "trouble" },
    },
  },
  {
    "SmiteshP/nvim-navic",
    lazy = false,
    opts = {
      separator = " 󰅂 ",
      highlight = true,
      depth_limit = 5,
      icons = {
        File = " ", Module = " ", Namespace = " ", Package = " ",
        Class = " ", Method = " ", Property = " ", Field = " ",
        Constructor = " ", Enum = " ", Interface = " ", Function = " ",
        Variable = " ", Constant = " ", String = " ", Number = " ",
        Boolean = " ", Array = " ", Object = " ", Key = " ",
        Null = " ", EnumMember = " ", Struct = " ", Event = " ",
        Operator = " ", TypeParameter = " ",
      },
    },
    config = function(_, opts)
      local navic = require("nvim-navic")
      navic.setup(opts)

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("jay_navic_attach", { clear = true }),
        callback = function(event)
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentSymbol, event.buf) then
            navic.attach(client, event.buf)
          end
        end,
      })

      vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      indent = { char = "│", tab_char = "│" },
      scope = { enabled = true, char = "│", show_start = false, show_end = false },
      exclude = {
        filetypes = {
          "help", "lazy", "man", "snacks_picker_input", "snacks_picker_list",
          "snacks_picker_preview", "terminal", "trouble",
        },
        buftypes = { "nofile", "prompt", "quickfix", "terminal" },
      },
    },
  },
}
