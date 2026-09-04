local M = {}

M.lsp = {
	laravel_lsp = {
		cmd = { require("config.laravel_lsp").ensure() },
		filetypes = { "php", "blade" },
		root_dir = function(bufnr, on_dir)
			local root = vim.fs.root(bufnr, "artisan")

			if root then
				on_dir(root)
			end
		end,
	},
	intelephense = {},
	lua_ls = {
		Lua = {
			runtime = { version = "LuaJIT" },
		},
	},
	gopls = {
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
				directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
				semanticTokens = true,
			},
		},
	},
	jsonls = {
		settings = {
			json = {
				schemas = require("schemastore").json.schemas(),
				validate = { enable = true },
			},
		},
	},
	marksman = {},
	prismals = {},
	tailwindcss = {
		filetype_exclude = { "markdown" },
		filetype_include = {},
		settings = {
			tailwindCSS = {
				classAttributes = { "class", "className", "class:list", "classList", "ngClass" },
				includeLanguages = {
					elixir = "html-eex",
					eelixir = "html-eex",
					heex = "html-eex",
				},
				lint = {
					cssConflict = "warning",
					invalidApply = "error",
					invalidConfigPath = "error",
					invalidScreen = "error",
					invalidTailwindDirective = "error",
					invalidVariant = "error",
					recommendedVariantOrder = "warning",
				},
				validate = true,
				experimental = {
					classRegex = {
						{ "(?:clsx|cn|cva|cx|twMerge|twJoin)\\(([^)]*)\\)", "[\"'`]([^\"'`]*?)[\"'`]" },
						"tw`([^`]*)`",
					},
				},
			},
		},
	},
	vtsls = {
		filetypes = {
			"javascript",
			"javascriptreact",
			"javascript.jsx",
			"typescript",
			"typescriptreact",
			"typescript.tsx",
		},
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
	yamlls = {
		settings = {
			yaml = {
				schemaStore = {
					enable = false,
					url = "",
				},
				schemas = require("schemastore").yaml.schemas(),
			},
		},
	},
}

return M
