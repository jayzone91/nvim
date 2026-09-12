local tools = require("config.tools")
local servers = tools.lsp
local formatter = tools.formatter
local linter = tools.linter
local mason_exclude = tools.mason_exclude
local server_names = vim.tbl_keys(servers)

return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    lazy = false,
    dependencies = {
      {
        "mason-org/mason-lspconfig.nvim",
        ---@type MasonLspconfigSettings
        opts = {
          ensure_installed = server_names,
          automatic_enable = server_names,
        },
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
      "b0o/SchemaStore.nvim",
    },
    ---@return MasonToolInstallerSettings
    opts = function()
      local SchemaStore = require("schemastore")

      servers.jsonls.settings.json.schemas = SchemaStore.json.schemas()
      servers.yamlls.settings.yaml.schemas = SchemaStore.yaml.schemas()

      local ensure_installed = {}
      local seen = {}

      local function add(name)
        if not seen[name] and not mason_exclude[name] then
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

      for _, tool in pairs(formatter) do
        for _, name in ipairs(tool) do
          add(name)
        end
      end

      for _, tool in pairs(linter) do
        for _, name in ipairs(tool) do
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

        { path = "hlchunk.nvim", words = { "HlChunk" } },
        { path = "noice.nvim", words = { "NoiceConfig" } },
        { path = "snacks.nvim", words = { "Snacks" } },

        { path = "nvim-lspconfig", words = { "lspconfig.settings" } },
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
