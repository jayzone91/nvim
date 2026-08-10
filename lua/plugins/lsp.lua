return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "snacks.nvim", words = { "Snacks" } },
      },
    },
  },
  {
    "saghen/blink.cmp",
    version = "1.*",
    lazy = false,
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    opts = {
      keymap = { preset = "default" },
      appearance = {
        nerd_font_variant = "mono",
        kind_icons = {
          Text = "󰉿",
          Method = "󰆧",
          Function = "󰊕",
          Constructor = "",
          Field = "󰜢",
          Variable = "󰀫",
          Property = "󰖷",
          Class = "󱡠",
          Interface = "",
          Struct = "󱡠",
          Module = "",
          Unit = "󰑭",
          Value = "󰎠",
          Enum = "",
          EnumMember = "",
          Keyword = "󰌋",
          Constant = "󰏿",
          Snippet = "",
          Color = "󰏘",
          File = "󰈙",
          Reference = "󰈇",
          Folder = "󰉋",
          Event = "",
          Operator = "󰆕",
          TypeParameter = "󰊄",
        },
      },
      completion = {
        menu = {
          border = "rounded",
          draw = {
            align_to = "label",
            padding = { 1, 1 },
            gap = 1,
            treesitter = { "lsp" },
            columns = {
              { "kind_icon" },
              { "label", "label_description", gap = 1 },
              { "kind" },
            },
            components = {
              kind_icon = {
                text = function(ctx)
                  return ctx.kind_icon .. ctx.icon_gap
                end,
                highlight = function(ctx)
                  return ctx.kind_hl
                end,
              },
              kind = {
                ellipsis = false,
                width = { max = 12 },
                text = function(ctx)
                  return ctx.kind
                end,
                highlight = function(ctx)
                  return ctx.kind_hl
                end,
              },
            },
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 150,
          update_delay_ms = 50,
          window = {
            border = "rounded",
            max_width = 60,
            max_height = 15,
          },
        },
        ghost_text = { enabled = true },
      },
      signature = {
        enabled = true,
        window = {
          border = "rounded",
          show_documentation = true,
        },
      },
      sources = {
        default = { "lazydev", "lsp", "path", "snippets", "buffer" },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100,
          },
        },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "mason-org/mason.nvim", cmd = "Mason", opts = {} },
      "neovim/nvim-lspconfig",
      "saghen/blink.cmp",
    },
    opts = {
      ensure_installed = {
        "bashls",
        "eslint",
        "gopls",
        "jsonls",
        "lua_ls",
        "mdx_analyzer",
        "prismals",
        "tailwindcss",
        "taplo",
        "vtsls",
        "yamlls",
      },
      automatic_enable = true,
    },
    config = function(_, opts)
      vim.lsp.config("*", { capabilities = require("blink.cmp").get_lsp_capabilities() })
      vim.lsp.config("vtsls", {
        settings = {
          typescript = {
            inlayHints = {
              parameterNames = { enabled = "literals" },
              parameterTypes = { enabled = true },
              variableTypes = { enabled = false },
              propertyDeclarationTypes = { enabled = true },
              functionLikeReturnTypes = { enabled = true },
              enumMemberValues = { enabled = true },
            },
          },
        },
      })
      local eslint_on_attach = vim.lsp.config.eslint.on_attach
      vim.lsp.config("eslint", {
        on_attach = function(client, bufnr)
          if eslint_on_attach then
            eslint_on_attach(client, bufnr)
          end
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            desc = "ESLint-Probleme vor dem Formatieren beheben",
            command = "LspEslintFixAll",
          })
        end,
      })
      vim.lsp.config("gopls", {
        settings = {
          gopls = {
            gofumpt = true,
            staticcheck = true,
            usePlaceholders = true,
            analyses = { nilness = true, unusedparams = true, unusedwrite = true },
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
          },
        },
      })
      vim.lsp.config("tailwindcss", {
        settings = {
          tailwindCSS = {
            classFunctions = { "cn", "cva", "clsx" },
          },
        },
      })
      vim.diagnostic.config({
        severity_sort = true,
        underline = true,
        update_in_insert = false,
        virtual_text = { spacing = 2, source = "if_many" },
        float = { border = "rounded", source = true },
      })
      require("mason-lspconfig").setup(opts)
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    event = "VeryLazy",
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      ensure_installed = {
        "bash-language-server",
        "eslint",
        "gofumpt",
        "goimports",
        "gopls",
        "jsonls",
        "lua_ls",
        "mdx_analyzer",
        "prettier",
        "prettierd",
        "prismals",
        "shellcheck",
        "shfmt",
        "stylua",
        "tailwindcss",
        "taplo",
        "vtsls",
        "yaml-language-server",
      },
      auto_update = true,
      run_on_start = true,
      start_delay = 3000,
    },
  },
}
