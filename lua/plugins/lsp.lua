return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "LspInfo", "LspInstall", "LspUninstall", "Mason" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "nvimtools/none-ls.nvim",
      "nvim-lua/plenary.nvim",
      { "folke/neodev.nvim", opts = {} },
      "j-hui/fidget.nvim",
      "jay-babu/mason-null-ls.nvim",
    },
    config = function()
      local null_ls = require("null-ls")
      local map_lsp_keybinds = require("keymaps").map_lsp_keybinds

      require("neodev").setup()

      require("mason").setup({
        ui = {
          border = "rounded",
        },
      })

      local servers = {
        cssls = {},
        html = {},
        jsonls = {},
        lua_ls = {
          settings = {
            Lua = {
              workspace = { checkThirdParty = false },
              telemetry = { enabled = false },
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        },
        marksman = {},
        prismals = {},
        pyright = {},
        sqlls = {},
        tailwindcss = {},
        tsserver = {
          settings = {
            experimantal = {
              enableProjectDiagnostics = true,
            },
          },
        },
        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              diagnostics = {
                enable = true,
              },
            },
          },
        },
        htmx = {},
      }
      local x = {}

      for server, _ in pairs(servers) do
        table.insert(x, server)
      end

      require("mason-lspconfig").setup({
        ensure_installed = x,
      })

      local default_handler = {
        ["textDocument/hover"] = vim.lsp.with(
          vim.lsp.handlers.hover,
          { border = "rounded" }
        ),
        ["textDocument/signatureHelp"] = vim.lsp.with(
          vim.lsp.handlers.signature_help,
          { border = "rounded" }
        ),
      }

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local default_capabilities =
        require("cmp_nvim_lsp").default_capabilities(capabilities)

      local on_attach = function(_, bufnr)
        map_lsp_keybinds(bufnr)

        vim.api.nvim_buf_create_user_command(bufnr, "Format", function()
          vim.lsp.buf.format({
            filter = function(format_client)
              return format_client.name ~= "tsserver"
                or not null_ls.is_registered("prettier")
            end,
          })
        end, { desc = "LSP: Format current buffer with LSP" })
      end

      for name, config in pairs(servers) do
        require("lspconfig")[name].setup({
          capabilities = default_capabilities,
          filetypes = config.filetypes,
          handler = vim.tbl_deep_extend(
            "force",
            {},
            default_handler,
            config.handler or {}
          ),
          on_attach = on_attach,
          settings = config.settings,
        })
      end

      local formatting = null_ls.builtins.formatting
      local diagnostics = null_ls.builtins.diagnostics
      local code_actions = null_ls.builtins.code_actions

      require("mason-null-ls").setup({
        ensure_installed = {
          "eslint_d",
          "prettierd",
          "stylua",
          "djlint",
        },
      })

      null_ls.setup({
        border = "rounded",
        sources = {
          formatting.prettierd,
          formatting.stylua,
          formatting.djlint,

          diagnostics.eslint_d.with({
            condition = function(utils)
              return utils.root_has_file({
                ".eslintrc.js",
                ".eslintrc.cjs",
                "eslintrc.json",
              })
            end,
            diagnostics.djlint,
          }),

          code_actions.eslint_d.with({
            condition = function(utils)
              return utils.root_has_file({
                ".eslintrc.js",
                ".eslintrc.cjs",
                ".eslintrc.json",
              })
            end,
          }),
        },
      })

      require("lspconfig.ui.windows").default_options.border = "rounded"

      vim.diagnostic.config({
        float = {
          border = "rounded",
        },
      })
    end,
  },
}
