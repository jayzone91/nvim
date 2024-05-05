-- Quickstart configs for Nvim LSP
-- https://github.com/neovim/nvim-lspconfig

local servers = require("config").server
local formatters = require("config").formatters
local linters = require("config").linters

return {
  "neovim/nvim-lspconfig",
  event = "BufEnter",
  dependencies = {
    -- Portable package manager for Neovim that runs everywhere Neovim runs. Easily install and manage LSP servers, DAP servers, linters, and formatters.
    -- https://github.com/williamboman/mason.nvim
    { "williamboman/mason.nvim", config = true },

    -- Extension to mason.nvim that makes it easier to use lspconfig with mason.nvim.
    -- https://github.com/williamboman/mason-lspconfig.nvim
    { "williamboman/mason-lspconfig.nvim" },

    -- Install and upgrade third party tools automatically
    -- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
    { "WhoIsSethDaniel/mason-tool-installer.nvim" },

    -- 💫 Extensible UI for Neovim notifications and LSP progress messages.
    -- https://github.com/j-hui/fidget.nvim
    { "j-hui/fidget.nvim", opts = {} },

    -- 💻 Neovim setup for init.lua and plugin development with full signature help, docs and completion for the nvim lua API.
    -- https://github.com/folke/neodev.nvim
    { "folke/neodev.nvim", opts = {} },
  },
  config = function()
    -- Create Mappings for LSP
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc)
          vim.keymap.set(
            "n",
            keys,
            func,
            { buffer = event.buf, desc = "LSP: " .. desc }
          )
        end

        local telescope_test, builtin = pcall(require, "telescope.builtin")
        if telescope_test then
          map(
            "gd",
            require("telescope.builtin").lsp_definitions,
            "[G]oto [D]efinition"
          )
          map(
            "gr",
            require("telescope.builtin").lsp_references,
            "[G]oto [R]eferences"
          )
          map(
            "gI",
            require("telescope.builtin").lsp_implementations,
            "[G]oto [I]mplementation"
          )
          map(
            "<leader>D",
            require("telescope.builtin").lsp_type_definitions,
            "Type [D]efinition"
          )
        end

        map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
        map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
        map("K", vim.lsp.buf.hover, "Hover Documentation")
        map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.documentHighlightProvider then
          local highlight_augroup =
            vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })
        end

        if
          client
          and client.server_capabilities.inlayHintProvider
          and vim.lsp.inlay_hint
        then
          map(
            "<leader>th",
            function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
            end,
            "[T]oggle Inlay [H]ints"
          )
        end

        if client.name == "tailwindcss" then
          pcall(require("telescope").load_extension, "tailiscope")
          vim.keymap.set(
            "n",
            "<leader>ft",
            "<cmd>Telescope tailiscope<cr>",
            { desc = "Find tailwindcss" }
          )
        end
      end,
    })

    vim.api.nvim_create_autocmd("LspDetach", {
      group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
      callback = function(event)
        vim.lsp.buf.clear_references()
        vim.api.nvim_clear_autocmds({
          group = "lsp-highlight",
          buffer = event.buf,
        })
      end,
    })

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local cmp_test, cmp = pcall(require, "cmp_nvim_lsp")
    if cmp_test then
      capabilities =
        vim.tbl_deep_extend("force", capabilities, cmp.default_capabilities())
    end

    local mason_test, mason = pcall(require, "mason")
    if not mason_test then
      return
    end

    mason.setup()

    local ensure_installed = vim.tbl_keys(servers or {})
    local lint = vim.tbl_values(linters or {})
    vim.list_extend(ensure_installed, formatters)
    vim.list_extend(ensure_installed, lint)

    local mti_test, mti = pcall(require, "mason-tool-installer")
    if not mti_test then
      return
    end

    mti.setup({
      ensure_installed = ensure_installed,
      auto_update = true,
      run_on_startup = true,
      start_delay = 3000,
    })

    local mlsp_test, mlsp = pcall(require, "mason-lspconfig")
    if not mlsp_test then
      return
    end

    mlsp.setup({
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          server.capabilites = vim.tbl_deep_extend(
            "force",
            {},
            capabilities,
            server.capabilities or {}
          )
          require("lspconfig")[server_name].setup(server)
        end,
      },
    })
  end,
}
