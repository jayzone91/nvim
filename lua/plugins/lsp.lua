return {
  "neovim/nvim-lspconfig",
  event = "BufEnter",
  dependencies = {
    -- Automatically install LSP Servers
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    -- Better Lua in Vim
    { "folke/neodev.nvim", opts = {} },
    -- CMP for autocomplete
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-nvim-lsp",
    -- Snippets for autocompletion
    "saadparwaiz1/cmp_luasnip", -- Snippets source for nvim-cmp
    -- Snippets plugin
    {
      "L3MON4D3/LuaSnip",
      -- follow latest release.
      version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
      -- install jsregexp (optional!).
      build = "make install_jsregexp"
    },
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
  },
  config = function()
    -- Automatically install LSP Servers
    require("mason").setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
        }
      }
    })
    require("mason-lspconfig").setup({
      ensure_installed = {
        "bashls",
        "cssls",
        "html",
        "htmx",
        "jsonls",
        "tsserver",
        "marksman",
        "intelephense",
        "pyright",
        "sqlls",
        "tailwindcss",
        "lua_ls",
        "rust_analyzer"
      },
      automatic_installation = true,
    })

    require("neodev").setup()
    local luasnip = require 'luasnip'
    require("luasnip.loaders.from_vscode").lazy_load()
    -- Enable Snippet capabilities for completion
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    -- Setup language Servers.
    local lspconfig = require("lspconfig")

    lspconfig.bashls.setup({
      capabilities = capabilities,
    })
    lspconfig.cssls.setup({
      capabilities = capabilities,
    })
    lspconfig.html.setup({
      capabilities = capabilities,
    })
    lspconfig.htmx.setup({
      capabilities = capabilities,
    })
    lspconfig.jsonls.setup({
      capabilities = capabilities,
    })
    lspconfig.tsserver.setup({
      setting = {
        experimental = {
          enableProjectDiagnostics = true,
        }
      },
      filetype = {
        "javascript",
        "typescript",
        "javascriptreact",
        "typescriptreact",
        "jsx",
        "tsx",
      },
      capabilities = capabilities,
    })
    lspconfig.marksman.setup({
      capabilities = capabilities,
    })
    lspconfig.intelephense.setup({
      capabilities = capabilities,
    })
    lspconfig.pyright.setup({
      capabilities = capabilities,
    })
    lspconfig.sqlls.setup({
      capabilities = capabilities,
    })
    lspconfig.tailwindcss.setup({
      capabilities = capabilities,
    })
    lspconfig.lua_ls.setup({
      settings = {
        Lua = {
          diagnostics = {
            globlas = { "vim" },
          },
          workspace = {
            checkThirdParty = false,
          },
          telemetry = { enabled = false, },
          codeLens = {
            enable = true,
          },
          completion = {
            callSnippet = "Replace",
          },
        },
      },
      capabilities = capabilities,
    })
    lspconfig.rust_analyzer.setup({
      settings = {
        ["rust-analyzer"] = {
          diagnostics = {
            enable = false,
          }
        }
      },
      capabilities = capabilities,
    })
    -- nvim-cmp setup
    local cmp = require 'cmp'
    cmp.setup {
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      completion = {
        completeopt = "menu,menuone,noinsert",
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
        ['<C-d>'] = cmp.mapping.scroll_docs(4),  -- Down
        -- C-b (back) C-f (forward) for snippet placeholder navigation.
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      }),
      experimental = {
        ghost_text = {
          hl_group = "CmpGhostText",
        },
      },
      sources = {
        { name = 'nvim_lsp' },
        { name = "path",    max_item_count = 3 },
        { name = 'luasnip', max_item_count = 3 },
        { name = "buffer",  max_item_count = 5 },
      },
    }
    -- Use LSPAttach autocmd to only map the following keys
    -- after the language server attaches to the current buffer
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<space>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<space>f', function()
          vim.lsp.buf.format { async = true }
        end, opts)
      end,
    })
  end,
}
