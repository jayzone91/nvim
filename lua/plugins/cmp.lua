return {
  "hrsh7th/nvim-cmp", -- Autocompletion Plugin
  lazy = true,
  event = "InsertEnter",
  dependencies = {
    -- CMP Additions
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    -- {
    --   "L3MON4D3/LuaSnip",           -- Snippets plugin
    --   dependencies = {
    --     "saadparwaiz1/cmp_luasnip", -- Snippets source for nvim-cmp
    --   },
    -- },
    -- {
    --   "rafamadriz/friendly-snippets",
    --   config = function()
    --     require("luasnip.loaders.from_vscode").lazy_load()
    --   end,
    -- },
  },
  config = function()
    -- luasnip
    -- local luasnip = require("luasnip")
    -- require("luasnip.loaders.from_vscode").lazy_load()
    -- luasnip.config.setup({})

    -- nvim cmp setup
    local cmp = require("cmp")
    cmp.setup({
      snippet = {
        expand = function(_)
          -- luasnip.lsp_expand(args.body)
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
            -- elseif luasnip.expand_or_jumpable() then
            --   luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
            -- elseif luasnip.jumpable(-1) then
            --   luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      sources = {
        { name = "nvim_lsp" },
        -- { name = "luasnip" },
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
  end,
}
