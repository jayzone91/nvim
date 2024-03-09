return {
  -- Quickstart configs for Nvim LSP
  "neovim/nvim-lspconfig",
  event = "BufEnter",
  dependencies = {
    -- Automatically install LSP Servers
    -- Portable package manager for Neovim that runs everywhere Neovim runs.
    -- Easily install and manage LSP servers, DAP servers, linters,
    -- and formatters.
    "williamboman/mason.nvim",
    -- Extension to mason.nvim that makes it easier to use lspconfig
    -- with mason.nvim.
    "williamboman/mason-lspconfig.nvim",
    {
      --💻 Neovim setup for init.lua and plugin development with full
      -- signature help, docs and completion for the nvim lua API.
      "folke/neodev.nvim",
      opts = {}
    },
    -- A completion plugin for neovim coded in Lua.
    "hrsh7th/nvim-cmp",
    -- nvim-cmp source for buffer words
    "hrsh7th/cmp-buffer",
    -- nvim-cmp source for path
    "hrsh7th/cmp-path",
    -- nvim-cmp source for neovim builtin LSP client
    "hrsh7th/cmp-nvim-lsp",
    -- luasnip completion source for nvim-cmp
    "saadparwaiz1/cmp_luasnip",
    -- Snippets plugin
    {
      -- Snippet Engine for Neovim written in Lua.
      "L3MON4D3/LuaSnip",
      -- follow latest release.
      version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
      -- install jsregexp (optional!).
      build = "make install_jsregexp"
    },
    dependencies = {
      -- Set of preconfigured snippets for different languages.
      "rafamadriz/friendly-snippets",
    },
    {
      -- 💫 Extensible UI for Neovim notifications and LSP progress messages.
      "j-hui/fidget.nvim",
      event = "BufReadPost",
      config = function() require("fidget").setup({}) end,
    },
  },
  config = function()
    -- Automatically install LSP Servers
    require("mason").setup({
      ui = {
        ---@since 1.0.0
        -- Whether to automatically check for new versions when opening the :Mason window.
        check_outdated_packages_on_open = true,

        ---@since 1.0.0
        -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
        border = "none",

        ---@since 1.0.0
        -- Width of the window. Accepts:
        -- - Integer greater than 1 for fixed width.
        -- - Float in the range of 0-1 for a percentage of screen width.
        width = 0.8,

        ---@since 1.0.0
        -- Height of the window. Accepts:
        -- - Integer greater than 1 for fixed height.
        -- - Float in the range of 0-1 for a percentage of screen height.
        height = 0.9,
        icons = {
          ---@since 1.0.0
          -- The list icon to use for installed packages.
          package_installed = "✓",
          ---@since 1.0.0
          -- The list icon to use for packages that are installing,
          -- or queued for installation.
          package_pending = "➜",
          ---@since 1.0.0
          -- The list icon to use for packages that are not installed.
          package_uninstalled = "✗"
        }
      }
    })
    require("mason-lspconfig").setup({
      -- A list of servers to automatically install if they're not already
      -- installed. Example: { "rust_analyzer@nightly", "lua_ls" }
      -- This setting has no relation with the `automatic_installation` setting.
      ---@type string[]
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
      -- Whether servers that are set up (via lspconfig) should be
      -- automatically installed if they're not already installed.
      -- This setting has no relation with the `ensure_installed` setting.
      -- Can either be:
      --   - false: Servers are not automatically installed.
      --   - true: All servers set up via lspconfig are automatically installed.
      --   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
      --       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
      ---@type boolean
      automatic_installation = true,
      -- See `:h mason-lspconfig.setup_handlers()`
      ---@type table<string, fun(server_name: string)>?
      handlers = nil,
    })
    -- IMPORTANT: make sure to setup neodev BEFORE lspconfig
    require("neodev").setup({
      -- add any options here, or leave empty to use the default settings
    })
    -- Add Snippets
    local luasnip = require 'luasnip'
    -- VS Code-like: To use existing VS Code style snippets
    -- from a plugin (eg. rafamadriz/friendly-snippets) simply
    -- install the plugin and then add
    require("luasnip.loaders.from_vscode").lazy_load()
    -- Enable Snippet capabilities for completion
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    -- The nvim-cmp almost supports LSP's capabilities so You should
    -- advertise it to LSP servers..
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    -- Setup language Servers.
    local lspconfig = require("lspconfig")

    -- Language server for bash, written using tree sitter in typescript.
    lspconfig.bashls.setup({
      capabilities = capabilities,
    })
    -- Neovim does not currently include built-in snippets.
    -- vscode-css-language-server only provides completions
    -- when snippet support is enabled. To enable completion,
    -- install a snippet plugin and add the following override
    -- to your language client capabilities during setup.
    lspconfig.cssls.setup({
      --Enable (broadcasting) snippet capability for completion
      capabilities = capabilities,
    })
    -- Neovim does not currently include built-in snippets.
    -- vscode-html-language-server only provides completions
    -- when snippet support is enabled. To enable completion,
    -- install a snippet plugin and add the following override
    -- to your language client capabilities during setup.
    lspconfig.html.setup({
      --Enable (broadcasting) snippet capability for completion
      capabilities = capabilities,
    })
    -- Lsp is still very much work in progress and experimental.
    -- Use at your own risk.
    lspconfig.htmx.setup({
      capabilities = capabilities,
    })
    -- vscode-json-language-server, a language server for JSON and JSON schema
    lspconfig.jsonls.setup({
      capabilities = capabilities,
    })
    -- To configure typescript language server,
    -- add a tsconfig.json or jsconfig.json to the root of your project.
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
    -- Marksman is a Markdown LSP server providing completion,
    -- cross-references, diagnostics, and more.
    lspconfig.marksman.setup({
      capabilities = capabilities,
    })
    -- Professional PHP tooling for any Language Server Protocol capable editor.
    lspconfig.intelephense.setup({
      capabilities = capabilities,
    })
    -- pyright, a static type checker and language server for python
    lspconfig.pyright.setup({
      capabilities = capabilities,
    })
    -- SQL Language Server
    lspconfig.sqlls.setup({
      capabilities = capabilities,
    })
    -- Intelligent Tailwind CSS tooling for Visual Studio Code
    lspconfig.tailwindcss.setup({
      capabilities = capabilities,
    })
    -- Lua language server.
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
    -- rust-analyzer (aka rls 2.0), a language server for Rust
    -- See docs for extra settings. The settings can be used like this:
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
    -- Set up nvim-cmp.
    local cmp = require 'cmp'
    cmp.setup {
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
          -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
          -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
          -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
          -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
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
      sources = cmp.config.sources(
        {
          { name = 'nvim_lsp' },
          { name = 'luasnip', max_item_count = 3 },
          {
            { name = "path",   max_item_count = 3 },
            { name = "buffer", max_item_count = 5 },
          },
        }
      )
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
