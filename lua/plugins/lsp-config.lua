local lsp_server = {
  "pyright",
  "rust_analyzer",
  "lua_ls",
  "tsserver",
}

return {
  "neovim/nvim-lspconfig",
  lazy = true,
  event = "BufEnter",
  opts = {
    inlay_hints = { enabled = true },
    capabilities = {
      workspace = {
        didChangeWatchedFiles = {
          dynamicRegistration = false,
        },
      },
    },
  },
  dependencies = {
    {
      -- Auto install LSPs
      "williamboman/mason-lspconfig.nvim",
      dependencies = {
        {
          "williamboman/mason.nvim",
        },
      },
      config = function()
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
          ensure_installad = lsp_server,
          automatic_installation = true,
        })
      end,
    },
    {
      -- Awesome autocompletion for Neovim init.lua and PLugin Development
      "folke/neodev.nvim",
      opts = {},
    },
    {
      -- Add Autocomplete / Snippet Support
      "hrsh7th/nvim-cmp", -- Autocompletion Plugin
      "hrsh7th/cmp-nvim-lsp", -- LSP Source for nvim-cmp
      "saadparwaiz1/cmp_luasnip", -- Snippets source for nvim-cmp
      "L3MON4D3/LuaSnip", -- Snippets plugins
    },
    {
      -- Add fancy loading indicator
      "j-hui/fidget.nvim",
      opts = {},
      config = function()
        require("fidget").setup({
          notification = { window = { winblend = 0 } },
        })
      end,
    },
  },
  config = function()
    -- IMPORTANT: Make sure to setup neodev BEFORE lspconfig
    require("neodev").setup()

    -- Add additional capabilities supported by nvim-cmp
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    -- Enable Autoformat on Save
    local on_attach = function(client, bufnr)
      if client.supports_method("textDocument/formatting") then
        local augroup = vim.api.nvim_create_augroup("LSPFormatting", {})
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
    end

    -- LSP Config
    local lspconfig = require("lspconfig")

    -- Configure all Server
    for _, server in ipairs(lsp_server) do
      lspconfig[server].setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })
    end

    -- Server Sepcific Settings (All automatic settings will be overridden
    lspconfig.rust_analyzer.setup({
      settings = { ["rust-analyzer"] = { diagnostics = { enable = true } } },
      on_attach = on_attach,
      capabilities = capabilities,
    })

    lspconfig.lua_ls.setup({
      settings = {
        Lua = {
          diagnostics = { globals = { "vim" } },
          runtime = { version = "LuaJIT" },
          workspace = { checkThirdParty = false },
          completion = { callSnippet = "Replace" },
          maxPreload = 100000,
          preloadFileSize = 10000,
          telemetry = { enabled = false },
        },
      },
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- Use LspAttach autocommand to only apple the following keys
    -- after the language srever attaches to the current buffer
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        -- Enable Completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

        -- Buffer local mappings
        -- see `:help vim.lsp.*` for documentation on any of the below functions
        local opts = function(desc)
          return { buffer = ev.buf, desc = desc }
        end
        vim.keymap.set(
          "n",
          "gD",
          vim.lsp.buf.declaration,
          opts("Go to Declaration")
        )
        vim.keymap.set(
          "n",
          "gd",
          vim.lsp.buf.definition,
          opts("Go to Definition")
        )
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts("Hover"))
        vim.keymap.set(
          "n",
          "gi",
          vim.lsp.buf.implementation,
          opts("Go to Implementations")
        )
        vim.keymap.set(
          "n",
          "gr",
          vim.lsp.buf.references,
          opts("Go to References")
        )
        vim.keymap.set(
          { "n", "v" },
          "<space>ca",
          vim.lsp.buf.code_action,
          opts("Code Actions")
        )
      end,
    })

    -- luasnip setup
    local luasnip = require("luasnip")
    require("luasnip.loaders.from_vscode").lazy_load()
    luasnip.config.setup()

    -- nvim cmp setup
    local has_words_before = function()
      unpack = unpack or table.unpack
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0
        and vim.api
            .nvim_buf_get_lines(0, line - 1, line, true)[1]
            :sub(col, col)
            :match("%s")
          == nil
    end

    local cmp = require("cmp")
    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      completion = { completeopt = "menu.menuone,noinsert" },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      mappings = cmp.mapping.preset.insert({
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
      }),
    })
  end,
}
