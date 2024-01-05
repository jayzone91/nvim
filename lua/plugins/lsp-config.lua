local utils = require("utils.mason")
local servers = utils.servers
local formatters = utils.formatters
local linters = utils.linters

return {
  {
    "neovim/nvim-lspconfig",
    lazy = true,
    event = "BufEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", -- LSP Source for nvim-cmp
      {
        -- Show Loading indicator
        "j-hui/fidget.nvim",
        opts = {},
        config = function()
          require("fidget").setup({
            notification = {
              window = {
                winblend = 0,
              },
            },
          })
        end,
      },
      {
        "folke/neodev.nvim",
        opts = {},
      }, -- Neovim api and docs support for lua,
      -- LSP autoinstall
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim", -- All other good Stuff
      {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        config = function()
          require("mason-tool-installer").setup({
            ensure_installed = { servers, formatters, linters },
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

      require("neodev").setup({
        -- add any options here, or leave empty to use the default settings
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

      capabilities.textDocument.completion.completionItem = {
        snippetSupport = true,
      }

      local augroup = vim.api.nvim_create_augroup("LSPFormatting", {})

      local on_attach = function(client, bufnr)
        -- Autoformat on Save
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({
            group = augroup,
            buffer = bufnr,
          })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format()
            end,
          })
        end

        local nmap = function(keys, func, desc)
          if desc then
            desc = "LSP: " .. desc
          end
          vim.keymap.set("n", keys, func, {
            buffer = bufnr,
            desc = desc,
          })
        end

        local builtin = require("telescope.builtin")

        nmap("<leader>gR", vim.lsp.buf.rename, "Rename")
        nmap("gd", builtin.lsp_definitions, "[G]oto [D]efinition")
        nmap("gr", builtin.lsp_references, "[G]oto [R]eferences")
        nmap("gI", builtin.lsp_implementations, "[G]oto [I]mplementation")
        nmap("<leader>D", builtin.lsp_type_definitions, "Type [D]efinition")
        nmap("<leader>ds", builtin.lsp_document_symbols, "[D]ocument [S]ymbols")
        nmap(
          "<leader>ws",
          builtin.lsp_dynamic_workspace_symbols,
          "[W]orkspace [S]ymbols"
        )
        nmap("K", vim.lsp.buf.hover, "Hover Documentation")
        nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")
        nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
        nmap(
          "<leader>wa",
          vim.lsp.buf.add_workspace_folder,
          "[W]orkspace [A]dd Folder"
        )
        nmap(
          "<leader>wr",
          vim.lsp.buf.remove_workspace_folder,
          "[W]orkspace [R]emove Folder"
        )
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
            telemetry = {
              enabled = false,
            },
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
    end,
  },
}
