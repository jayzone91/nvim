return {
  {
    "hrsh7th/nvim-cmp",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
      "onsails/lspkind.nvim",
      "windwp/nvim-ts-autotag",
      "windwp/nvim-autopairs",
    },
    config = function()
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")

      require("nvim-autopairs").setup()

      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args) luasnip.lsp_expand(args.body) end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
          ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
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
          ["<C-u>"] = cmp.mapping.scroll_docs(4), -- scroll up preview
          ["<C-d>"] = cmp.mapping.scroll_docs(-4), -- scroll down preview
          ["<C-Space>"] = cmp.mapping.complete({}), -- show completion suggestions
          ["<C-c>"] = cmp.mapping.abort(), -- close completion window
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- select suggestion
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "buffer", max_item_count = 5 },
          { name = "path", max_item_count = 3 },
          { name = "luasnip", max_item_count = 3 },
        }),
        ---@diagnostic disable-next-line: missing-fields
        formatting = {
          expandable_indicator = true,
          format = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
            ellipsis_char = "...",
          }),
        },
        experimental = {
          ghost_text = true,
        },
      })
    end,
  },
}
