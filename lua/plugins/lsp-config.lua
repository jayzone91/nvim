local utils = require("utils.mason")
local servers = utils.servers
local formatters = utils.formatters
local linters = utils.linters

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", -- LSP Source for nvim-cmp
      {
        -- Show Loading indicator
        "j-hui/fidget.nvim",
        opts = {},
      },
      { "folke/neodev.nvim", opts = {} }, -- Neovim api and docs support for lua,
      -- LSP autoinstall
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",

      -- All other good Stuff
      {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        config = function()
          require("mason-tool-installer").setup({
            ensure_installed = {
              servers,
              formatters,
              linters,
            },
            auto_update = true,
            run_on_start = true,
            start_delay = 3000,
          })
        end,
      },
    },
    config = function()
      -- install LSP Servers
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })
      require("mason-lspconfig").setup({
        -- ensure_installed = servers,
        automatic_installation = true,
      })

      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      capabilities.textDocument.completion.completionItem = {
        snippetSupport = true,
      }
      require("neodev").setup({
        -- add any options here, or leave empty to use the default settings
      })

      local augroup = vim.api.nvim_create_augroup("LSPFormatting", {})

      local on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format()
            end,
          })
        end
      end

      local lspconfig = require("lspconfig")

      -- Enable some language Servers with the additional completion
      -- capabilities offered by nvim-cmp

      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup({
          capabilities = capabilities,
          on_attach = on_attach,
        })
      end

      lspconfig.lua_ls.setup({
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            runtime = {
              version = "LuaJIT",
            },
            workspace = {
              checkThirdParty = false,
            },
            completion = {
              callSnippet = "Replace",
            },
            maxPreload = 100000,
            preloadFileSize = 10000,
          },
        },
        capabilities = capabilities,
        on_attach = on_attach,
      })

      lspconfig.emmet_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = {
          "html",
          "pug",
          "typescriptreact",
          "javascript",
          "javascriptreact",
          "svelte",
          "vue",
          "css",
          "sass",
          "scss",
          "less",
        },
        init_options = {
          ["bem.enabled"] = true,
        },
      })

      lspconfig.tailwindcss.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        cmd = { "tailwindcss-language-server", "--stdio" },
        filetypes = {
          "html",
          "njk",
          "nunjucks",
          "php",
          "sass",
          "scss",
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
        },
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.onmifunc"

          local opts = function(desc)
            return { buffer = ev.buf, desc = desc }
          end

          vim.keymap.set(
            "n",
            "gD",
            vim.lsp.buf.declaration,
            opts("Declaration")
          )
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts("Definition"))
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts("Hover"))
          vim.keymap.set(
            "n",
            "gi",
            vim.lsp.buf.implementation,
            opts("Implementation")
          )
          vim.keymap.set(
            "n",
            "<leader>D",
            vim.lsp.buf.type_definition,
            opts("Type definition")
          )
          vim.keymap.set(
            { "n", "v" },
            "<leader>ca",
            vim.lsp.buf.code_action,
            opts("Code Actions")
          )
          vim.keymap.set("n", "gR", vim.lsp.buf.rename, opts("Rename"))
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts("References"))
          vim.keymap.set("n", "<leader>df", function()
            vim.lsp.buf.format({ async = false })
          end, opts("Format"))
        end,
      })
    end,
  },
}
