local M = {}

M.lsp = {
  emmet_language_server = {
    filetypes = {
      "html",
      "css",
      "scss",
      "javascriptreact",
      "typescriptreact",
      "blade",
    },
  },
  powershell_es = {
    bundle_path = vim.fn.stdpath("data")
      .. "/mason/packages/powershell-editor-services",
  },
  taplo = {},
  eslint = {},
  lua_ls = {},
  tailwindcss = {
    ---@type lspconfig.settings.tailwindcss
    settings = {
      tailwindCSS = {
        experimental = {
          classRegex = {
            {
              "(?:clsx|cn|cva|cx|twMerge|twJoin)\\(([^)]*)\\)",
              "[\"'`]([^\"'`]*?)[\"'`]",
            },
            "tw`([^`]*)`",
            "cn`([^`]*)`",
          },
        },
      },
    },
  },
  vtsls = {
    filetypes = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
    },
    ---@type lspconfig.settings.vtsls
    settings = {
      complete_function_calls = true,
      vtsls = {
        enableMoveToFileCodeAction = true,
        autoUseWorkspaceTsdk = true,
        experimental = {
          maxInlayHintLength = 30,
          completion = {
            enableServerSideFuzzyMatch = true,
          },
        },
      },
      typescript = {
        updateImportsOnFileMove = { enabled = "always" },
        suggest = {
          completeFunctionCalls = true,
        },
        inlayHints = {
          enumMemberValues = { enabled = true },
          functionLikeReturnTypes = { enabled = true },
          parameterNames = { enabled = "literals" },
          parameterTypes = { enabled = true },
          propertyDeclarationTypes = { enabled = true },
          variableTypes = { enabled = false },
        },
      },
    },
  },
  html = {},
  cssls = {},
  jsonls = {
    ---@type lspconfig.settings.jsonls
    settings = {
      json = {
        validate = { enable = true },
      },
    },
  },
  yamlls = {
    ---@type lspconfig.settings.yamlls
    settings = {
      yaml = {
        schemaStore = {
          enable = false,
          url = "",
        },
      },
    },
  },
  marksman = {},
  mdx_analyzer = {
    cmd = { "mdx-language-server", "--stdio" },
    filetypes = { "mdx" },
    root_markers = {
      "package.json",
      "tsconfig.json",
      "jsconfig.json",
      ".git",
    },
  },
  gopls = {
    ---@type lspconfig.settings.gopls
    settings = {
      gopls = {
        gofumpt = true,
        codelenses = {
          gc_details = false,
          generate = true,
          regenerate_cgo = true,
          run_govulncheck = true,
          test = true,
          tidy = true,
          upgrade_dependency = true,
          vendor = true,
        },
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          constantValues = true,
          functionTypeParameters = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
        analyses = {
          nilness = true,
          unusedparams = true,
          unusedwrite = true,
          useany = true,
        },
        usePlaceholders = true,
        completeUnimported = true,
        staticcheck = true,
        directoryFilters = {
          "-.git",
          "-.vscode",
          "-.idea",
          "-.vscode-test",
          "-node_modules",
        },
      },
    },
  },
  intelephense = {},
  prismals = {},
}

M.formatter = {
  php = { "pint" },
  blade = { "blade-formatter" },
  lua = { "stylua" },
  javascript = { "prettier" },
  typescript = { "prettier" },
  javascriptreact = { "prettier" },
  typescriptreact = { "prettier" },
  html = { "prettier" },
  css = { "prettier" },
  scss = { "prettier" },
  astro = { "prettier" },
  go = { "goimports", "gofumpt" },
  markdown = { "prettier", "markdownlint-cli2", "markdown-toc" },
  mdx = { "prettier" },
  yaml = { "prettier" },
}

M.linter = {
  php = { "phpstan" },
}

return M
