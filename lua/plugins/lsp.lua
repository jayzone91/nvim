return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    lazy = false,
    dependencies = {
      {
        "mason-org/mason-lspconfig.nvim",
        opts = function()
          local servers = require("config.tools").lsp

          local ensure_installed = {}

          for name in pairs(servers) do
            table.insert(ensure_installed, name)
          end

          ---@type MasonLspconfigSettings
          return {
            ensure_installed = ensure_installed,
            automatic_enable = ensure_installed,
          }
        end,
      },
      {
        "mason-org/mason.nvim",
        ---@type MasonSettings
        opts = {
          ui = {
            icons = {
              package_installed = "✓",
              package_pending = "➜",
              package_uninstalled = "✗",
            },
          },
        },
      },
      "neovim/nvim-lspconfig",
    },
    ---@return MasonToolInstallerSettings
    opts = function()
      local servers = require("config.tools").lsp
      local formatter = require("config.tools").formatter

      local ensure_installed = {}
      local seen = {}

      local function add(name)
        if not seen[name] then
          seen[name] = true
          table.insert(ensure_installed, name)
        end
      end

      for name, config in pairs(servers) do
        add(name)

        if next(config) then
          vim.lsp.config(name, config)
        end
      end

      for _, tools in pairs(formatter) do
        for _, name in ipairs(tools) do
          add(name)
        end
      end
      return {
        ensure_installed = ensure_installed,
        auto_update = true,
        start_delay = 3000,
        debounce_hours = 3,
      }
    end,
  },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "snacks.nvim", words = { "Snacks" } },
        { path = "nvim-lspconfig", words = { "lspconfig.settings" } },
        { path = "bufferline.nvim", words = { "bufferline" } },
        { path = "blink.cmp", words = { "blink.cmp" } },
        { path = "conform.nvim", words = { "conform" } },
        { path = "hlchunk.nvim", words = { "HlChunk" } },
        { path = "mason-lspconfig.nvim", words = { "MasonLspconfigSettings" } },
        { path = "mason.nvim", words = { "MasonSettings" } },
        {
          path = "mason-tool-installer.nvim",
          words = { "MasonToolInstallerSettings" },
        },
      },
    },
  },
}
