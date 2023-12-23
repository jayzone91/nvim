local servers = {
  "lua_ls",
  "tsserver",
  "cssls",
  "marksman",
  "jsonls",
  "html",
  "emmet_ls",
  "taplo",
  "prismals",
}

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        -- Show Loading indicator
        "j-hui/fidget.nvim",
        opts = {}
      },
      "hrsh7th/nvim-cmp",         -- Autocompletion Plugin
      "hrsh7th/cmp-nvim-lsp",     -- LSP Source for nvim-cmp
      "saadparwaiz1/cmp_luasnip", -- Snippets source for nvim-cmp
      "L3MON4D3/LuaSnip",         -- Snippets plugin
      {
        "rafamadriz/friendly-snippets",
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
        end,
      },
      { "folke/neodev.nvim", opts = {} }, -- Neovim api and docs support for lua,
      -- LSP autoinstall
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
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
        ensure_installed = servers,
        automatic_installation = true,
      })

      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true
      require("neodev").setup({
        -- add any options here, or leave empty to use the default settings
      })

      local lspconfig = require("lspconfig")

      -- Enable some language Servers with the additional completion
      -- capabilities offered by nvim-cmp

      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup({
          capabilities = capabilities,
        })
      end

      lspconfig.lua_ls.setup({
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
            workspace = {
              checkThirdParty = false,
            },
            completion = {
              callSnippet = "Replace",
            },
          },
        },
        capabilities = capabilities,
      })

      lspconfig.emmet_ls.setup({
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

      -- luasnip
      local luasnip = require("luasnip")
      require("luasnip.loaders.from_vscode").lazy_load()
      -- nvim cmp setup
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-u>"] = cmp.mapping.scroll_docs(-4), -- Up
          ["<C-d>"] = cmp.mapping.scroll_docs(4),  -- Down
          -- C-b (back) C-f (forward) for snippet placeholder navigation.
          ["<C-space>"] = cmp.mapping.complete(),
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
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts("References"))
          vim.keymap.set("n", "<leader>df", function()
            vim.lsp.buf.format({ async = false })
          end, opts("Format"))
        end,
      })
    end,
  },
}
