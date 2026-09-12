local function lsp_clients()
  local clients = vim.lsp.get_clients({
    bufnr = vim.api.nvim_get_current_buf(),
  })

  if #clients == 0 then
    return ""
  end

  local names = {}

  for _, client in ipairs(clients) do
    names[#names + 1] = client.name
  end

  table.sort(names)

  if #names == 1 then
    return names[1]
  end

  return string.format("%d LSPs", #names)
end

return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = function()
    local colors = require("rose-pine.palette")

    return {
      options = {
        globalstatus = true,

        component_separators = {
          left = "│",
          right = "│",
        },

        section_separators = {
          left = "",
          right = "",
        },

        disabled_filetypes = {
          statusline = {
            "snacks_dashboard",
          },
        },
      },

      sections = {
        lualine_a = {
          {
            "mode",
            fmt = function(mode)
              return "  " .. mode
            end,
            separator = {
              right = "",
            },
          },
        },

        lualine_b = {
          {
            "branch",
            icon = "",
            color = {
              fg = colors.iris,
              bg = colors.surface,
              gui = "bold",
            },
          },
          {
            "diff",
            symbols = {
              added = " ",
              modified = " ",
              removed = " ",
            },
          },
        },

        lualine_c = {
          {
            "filetype",
            icon_only = true,
            separator = "",
            padding = { right = 0 },
          },
          {
            "filename",
            path = 1,
            padding = { left = 0 },
            fmt = function(filename)
              return filename:gsub("\\", "/")
            end,
            symbols = {
              modified = " ●",
              readonly = " ",
              unnamed = " [No Name]",
              newfile = " ",
            },
          },
        },

        lualine_x = {
          {
            "searchcount",
            maxcount = 9999,
            timeout = 500,
          },
          {
            "selectioncount",
          },
          {
            function()
              return require("nvim-lightbulb").get_status_text()
            end,
            cond = function()
              return require("nvim-lightbulb").get_status_text() ~= ""
            end,
            color = {
              fg = colors.gold,
              gui = "bold",
            },
            separator = "",
          },
          {
            "diagnostics",
            symbols = {
              error = " ",
              warn = " ",
              info = " ",
              hint = "󰛩 ",
            },
          },
          { "filesize" },
          {
            "lsp_status",
            icon = "",
            symbols = {
              spinner = {
                "⠋",
                "⠙",
                "⠹",
                "⠸",
                "⠼",
                "⠴",
                "⠦",
                "⠧",
                "⠇",
                "⠏",
              },
              done = "󰒋 ",
              separator = " ",
            },
            show_name = false,
            color = {
              fg = colors.foam,
              bg = colors.surface,
            },
            separator = {
              left = "",
              right = " ",
            },
            padding = { right = 1 },
          },
          {
            lsp_clients,
            padding = { left = 0 },
            color = {
              fg = colors.foam,
              bg = colors.surface,
            },
          },
        },

        lualine_y = {
          {
            "filetype",
            icon_only = false,
            color = { fg = colors.rose, bg = colors.surface },
            fmt = function(filetype)
              local names = {
                javascript = "JS",
                javascriptreact = "JSX",
                typescript = "TS",
                typescriptreact = "TSX",
              }

              return names[filetype] or filetype
            end,
            separator = {
              left = "",
            },
          },
          "progress",
        },

        lualine_z = {
          {
            "location",
            fmt = function(location)
              return "󰍎 " .. location
            end,
            separator = {
              left = "",
            },
          },
        },
      },

      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          {
            "filename",
            path = 1,
          },
        },
        lualine_x = {
          "location",
        },
        lualine_y = {},
        lualine_z = {},
      },
    }
  end,
}
