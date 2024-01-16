local servers = {
  "pyright",
  "rust_analyzer",
  "lua_ls",
  "tsserver",
  "cssls",
  "marksman", -- markdown
  "jsonls",
  "html",
  "taplo", -- Toml
  "prismals",
}


return {
  "neovim/nvim-lspconfig",
  lazy = true,
  event = "BufEnter",
  dependencies = {
    -- CMP
    {
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    -- Mason
    {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim"
    },
    -- Showing Loading indicators
    {
      "j-hui/fidget.nvim",
      opts = {},
      config = function()
        require("fidget").setup({
          notification = {
            window = {
              winblend = 0
            },
          },
        })
      end,
    },
    {
      "folke/neodev.nvim",
      opts = {},
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
      ensure_installed = servers,
      automatic_installation = true,
    })
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    capabilities.textDocument.completion.completionItem = {
      snippetSupport = true,
    }

    local augroup = vim.api.nvim_create_augroup("LSPFormatting", {})

    local on_attach = function(client, bufnr)
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
      nmap("K", vim.lsp.buf.hover, "Hover Documentation")
      nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")
      nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
    end


    require("neodev").setup()
    local has_words_befor = function()
      unpack = unpack or table.unpack
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0
          and vim.api
          .nvim_buf_get_lines(0, line - 1, line, true)[1]
          :sub(col, col)
          :match("%s")
          == nil
    end
    local luasnip = require("luasnip")
    require("luasnip.loaders.from_vscode").lazy_load()
    luasnip.config.setup({})
    local cmp = require("cmp")
    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      completion = {
        completeopt = "menu,menuone,noinsert",
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      mapping = cmp.mapping.preset.insert({
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_befor() then
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
        ["<C-v>"] = cmp.mapping.scroll_docs(-4),
        ["<C-b>"] = cmp.mapping.scroll_docs(4),
        ["<C-space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
      }),
      sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
      },
    })

    -- Set configuration for specific filetype.
    cmp.setup.filetype("gitcommit", {
      sources = cmp.config.sources({
        { name = "git" },
      }, {
        { name = "buffer" },
      }),
    })

    -- Use buffer source for "/" and "?"
    cmp.setup.cmdline({ "/", "?" }, {
      mappings = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })

    -- use cmdline & path for ":"
    cmp.setup.cmdline(":", {
      mappings = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        { name = "cmdline" },
      }),
    })
    local lspconfig = require("lspconfig")

    for _, lsp in ipairs(servers) do
      lspconfig[lsp].setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })
    end


    lspconfig.rust_analyzer.setup({
      settings = {
        ["rust-analyzer"] = {
          diagnostics = {
            enable = true,
          },
        },
      },
      capabilities = capabilities,
      on_attach = on_attach,
    })

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
  end,
}
