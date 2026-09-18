local function tabout()
  local keys =
    vim.api.nvim_replace_termcodes("<Plug>(Tabout)", true, true, true)

  vim.api.nvim_feedkeys(keys, "", false)

  return true
end

local function tabout_back()
  local keys =
    vim.api.nvim_replace_termcodes("<Plug>(TaboutBack)", true, true, true)

  vim.api.nvim_feedkeys(keys, "", false)

  return true
end

return {
  "saghen/blink.cmp",
  version = "1.*",
  event = "InsertEnter",
  dependencies = {
    "rafamadriz/friendly-snippets",
    "dsznajder/vscode-es7-javascript-react-snippets",
    "xzbdmw/colorful-menu.nvim",
  },
  ---@module "blink.cmp"
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      preset = "enter",
      ["<Tab>"] = {
        "snippet_forward",
        tabout,
        "fallback",
      },
      ["<S-Tab>"] = {
        "snippet_backward",
        tabout_back,
        "fallback",
      },
      ["<Esc>"] = {
        "hide",
        "fallback",
      },
    },
    completion = {
      list = {
        selection = {
          preselect = true,
          auto_insert = false,
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 300,
      },
      ghost_text = {
        enabled = true,
      },
      menu = {
        border = "rounded",
        draw = {
          padding = { 0, 1 },
          columns = {
            { "kind_icon" },
            { "label", gap = 1 },
            { "kind", gap = 1 },
          },
          components = {
            label = {
              text = function(ctx)
                return require("colorful-menu").blink_components_text(ctx)
              end,
              highlight = function(ctx)
                return require("colorful-menu").blink_components_highlight(ctx)
              end,
            },
            kind_icon = {
              text = function(ctx)
                return " " .. ctx.kind_icon .. ctx.icon_gap .. " "
              end,
              highlight = function(ctx)
                return {
                  {
                    group = ctx.kind_hl,
                    priority = 20000,
                  },
                }
              end,
            },
          },
          treesitter = { "lsp" },
        },
      },
    },
    signature = {
      enabled = true,
    },
    fuzzy = {
      implementation = "prefer_rust_with_warning",
      sorts = { "exact", "score", "sort_text" },
    },
    sources = {
      default = { "lsp", "snippets", "path", "buffer" },
      providers = {
        lsp = {
          score_offset = 4,
          opts = {
            tailwind_color_icon = "██",
          },
        },
        snippets = {
          score_offset = -1,
          opts = {
            search_paths = {
              vim.fn.stdpath("data")
                .. "/lazy/vscode-es7-javascript-react-snippets",
            },
          },
        },
        buffer = {
          score_offset = -3,
        },
      },
    },
  },
}
