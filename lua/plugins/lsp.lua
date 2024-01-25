return {
  "VonHeikemen/lsp-zero.nvim",
  branch = "v2.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    -- LSP Support
    { "neovim/nvim-lspconfig" },
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    -- null-ls
    { "nvimtools/none-ls.nvim" },
    { "jay-babu/mason-null-ls.nvim" },

    -- Autocompletion
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "saadparwaiz1/cmp_luasnip" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-nvim-lua" },

    -- Snippets
    { "L3MON4D3/LuaSnip", version = "2.*" },
    { "rafamadriz/friendly-snippets" },
    -- Autopairs
    { "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },
    -- Loading indicator
    { "j-hui/fidget.nvim", opts = {} },
  },
  config = function()
    -- Luasnip
    local ls = require("luasnip")

    vim.keymap.set(
      { "i" },
      "<C-K>",
      function() ls.expand() end,
      { silent = true }
    )

    vim.keymap.set(
      { "i", "s" },
      "<C-L>",
      function() ls.jump(1) end,
      { silent = true }
    )

    vim.keymap.set(
      { "i", "s" },
      "<C-H>",
      function() ls.jump(-1) end,
      { silent = true }
    )

    vim.keymap.set({ "i", "s" }, "<C-E>", function()
      if ls.choice_active() then
        ls.change_choice(1)
      end
    end, { silent = true })

    require("luasnip.loaders.from_vscode").lazy_load()

    local lsp = require("lsp-zero").preset({})

    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "tsserver",
        "pyright",
        "rust_analyzer",
      },
      automatic_installation = false,
    })
    require("mason-null-ls").setup({
      ensure_installed = {
        "stylua",
      },
      automatic_installation = false,
    })

    lsp.on_attach(function(client, bufnr)
      -- lsp.default_keymaps({ buffer = bufnr })
      local opts = { buffer = bufnr, silent = true }
      vim.keymap.set(
        "n",
        "<leader>ca",
        vim.lsp.code_action,
        { buffer = bufnr, silent = true, desc = "Code Actions" }
      )
      vim.keymap.set(
        "n",
        "gR",
        vim.lsp.buf.rename,
        { buffer = bufnr, silent = true, desc = "Rename" }
      )
      vim.keymap.set(
        "n",
        "gi",
        vim.lsp.buf.implementation,
        { buffer = bufnr, silent = true, desc = "implementation" }
      )
      vim.keymap.set(
        "n",
        "gr",
        vim.lsp.buf.references,
        { buffer = bufnr, silent = true, desc = "references" }
      )
      vim.keymap.set(
        "n",
        "gd",
        vim.lsp.buf.definition,
        { buffer = bufnr, silent = true, desc = "definition" }
      )
      vim.keymap.set(
        "n",
        "gD",
        vim.lsp.buf.declaration,
        { buffer = bufnr, silent = true, desc = "declaration" }
      )
      vim.keymap.set(
        "n",
        "K",
        vim.lsp.buf.hover,
        { buffer = bufnr, silent = true, desc = "hover" }
      )

      -- Format on Save
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
      require("null-ls").setup({
        -- you can reuse a shared lspconfig on_attach callback here
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                -- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
                vim.lsp.buf.format({ asnyc = false })
              end,
            })
          end
        end,
      })
    end)

    lsp.setup()

    require("cmp").setup({
      performance = {
        debounce = 0,
        throttle = 0,
        confirm_resolve_timeout = 0,
      },
      preselect = "Item",
      snippet = {
        expand = function(args) require("luasnip").lsp_expand(args.body) end,
      },
      sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "nvim_lua" },
      },
      view = {},
      window = {
        completion = {
          border = "rounded",
        },
        documentation = {
          border = "rounded",
        },
      },
    })

    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    local cmp = require("cmp")
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

    -- FIX THE THINGY WITH THE WARNING
    local lspconfig = require("lspconfig")
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    capabilities.offsetEncoding = "utf-8"
    capabilities.offset_encoding = "utf-8"
    capabilities.clang = {}
    capabilities.clang.offsetEncoding = "utf-8"
    capabilities.clang.offset_encoding = "utf-8"
    lspconfig.clangd.setup({ capabilities = capabilities })
    -- AAAAAA

    local null_ls = require("null-ls")
    local null_opts = lsp.build_options("null-ls", {})

    null_ls.setup({
      on_attach = function(client, bufnr) null_opts.on_attach(client, bufnr) end,
      sources = {
        null_ls.builtins.formatting.stylua,
      },
    })
  end,
}
