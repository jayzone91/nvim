-- Language Servers to be installed with Mason and Setup with LSP Config
local servers = {
  "lua_ls",
  "tsserver",
  "rust_analyzer",
  "pyright",
  "htmx",
}

return {
  "neovim/nvim-lspconfig",
  lazy = true,
  event = "BufEnter",
  dependencies = {
    -- Neovim Signature Help
    "folke/neodev.nvim",
    -- Automatic Language Server installation
    { "williamboman/mason.nvim", opts = {} },
    {
      "williamboman/mason-lspconfig.nvim",
      config = function()
        require("mason-lspconfig").setup({
          ensure_installed = servers,
          automatic_installation = true,
          handlers = nil,
        })
      end,
    },
    -- Autocompletion Plugins
    "hrsh7th/nvim-cmp",     -- Autocompletion plugin
    "hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "saadparwaiz1/cmp_luasnip", -- Snippets source for nvim-cmp
    "L3MON4D3/LuaSnip",         -- Snippets plugin

    -- AI Autocompletion
    {
      "Exafunction/codeium.nvim",
      opts = {},
    },

    -- Loading Indicator
    { "j-hui/fidget.nvim",       opts = {} },
  },
  config = function()
    -- Init neodev
    require("neodev").setup()

    -- Config capabilities
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- Use on_attach function to enable format on save if supported by Language server
    local on_attach = function(client, bufnr)
      local augroup = vim.api.nvim_create_augroup("FormatOnSave", {})
      if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = augroup,
          buffer = bufnr,
          callback = function() vim.lsp.buf.format({ async = false }) end,
        })
      end
    end

    -- Setup Language Servers
    local lspconfig = require("lspconfig")
    -- Automatic Configuration
    for _, server in ipairs(servers) do
      lspconfig[server].setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })
    end

    -- Manual Config
    lspconfig.lua_ls.setup({
      settings = {
        Lua = {
          --runtime = {
          --version = "LuaJIT",
          --},
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME,
            },
          },
          completion = {
            callSnippet = "Replace",
          },
        },
      },
      on_attach = on_attach,
      capabilities = capabilities,
    })

    lspconfig.rust_analyzer.setup({
      settings = {
        ["rust-analyzer"] = {
          diagnostics = {
            enable = true,
          },
        },
      },
    })

    -- Use LspAttach autocmd to only map the following keys after the
    -- Language Server attaces to the current buffer
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("LSPUserConfig", {}),
      callback = function(ev)
        vim.keymap.set(
          "n",
          "gD",
          vim.lsp.buf.declaration,
          { buffer = ev.buf, desc = "Goto Declaration" }
        )
        vim.keymap.set(
          "n",
          "gd",
          vim.lsp.buf.definition,
          { buffer = ev.buf, desc = "Goto Definition" }
        )
        vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = ev.buf })
        vim.keymap.set(
          "n",
          "gi",
          vim.lsp.buf.implementation,
          { buffer = ev.buf, desc = "Goto Implementation" }
        )
        vim.keymap.set(
          "n",
          "gR",
          vim.lsp.buf.rename,
          { buffer = ev.buf, desc = "Rename" }
        )
        vim.keymap.set(
          "n",
          "<leader>ca",
          vim.lsp.buf.code_action,
          { buffer = ev.buf, desc = "Code Actions" }
        )
        vim.keymap.set(
          "n",
          "<leader>fm",
          function() vim.lsp.buf.format({ async = false }) end,
          { buffer = ev.buf, desc = "Format File" }
        )
      end,
    })

    -- Configure CMP autocomplete and snippets
    local luasnip = require("luasnip")
    local cmp = require("cmp")

    cmp.setup({
      completion = {
        completeopt = "menu,menuone,noinsert",
      },
      snippet = {
        expand = function(args) luasnip.lsp_expand(args.body) end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-u>"] = cmp.mapping.scroll_docs(-4), -- Up
        ["<C-d>"] = cmp.mapping.scroll_docs(4),  -- Down
        -- C-b (back) C-f (forward) for snippet placeholder navigation.
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
      sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
      },
    })
  end,
}
