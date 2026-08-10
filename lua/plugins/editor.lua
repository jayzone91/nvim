return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      dashboard = {
        enabled = true,
        preset = {
          header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
          keys = {
            {
              icon = " ",
              key = "n",
              desc = "Neue Datei",
              action = "<cmd>ene<cr><cmd>startinsert<cr>",
            },
            {
              icon = " ",
              key = "f",
              desc = "Datei suchen",
              action = function()
                Snacks.picker.files()
              end,
            },
            {
              icon = " ",
              key = "r",
              desc = "Letzte Dateien",
              action = function()
                Snacks.picker.recent()
              end,
            },
            {
              icon = " ",
              key = "p",
              desc = "Projekte",
              action = function()
                Snacks.picker.projects()
              end,
            },
            {
              icon = " ",
              key = "e",
              desc = "Datei-Explorer",
              action = function()
                Snacks.explorer()
              end,
            },
            {
              icon = "󰒲 ",
              key = "l",
              desc = "Plugins verwalten",
              action = "<cmd>Lazy<cr>",
            },
            {
              icon = "󰚰 ",
              key = "u",
              desc = "Plugins aktualisieren",
              action = "<cmd>Lazy update<cr>",
            },
            {
              icon = " ",
              key = "q",
              desc = "Neovim beenden",
              action = "<cmd>qa<cr>",
            },
          },
        },
        sections = {
          { section = "header" },
          { section = "keys", gap = 1, padding = 1 },
          {
            function()
              local checker = require("lazy.manage.checker")
              checker.fast_check({ report = false })

              local count = #checker.updated
              local status = count == 1 and "1 Update verfügbar" or count .. " Updates verfügbar"

              return {
                align = "center",
                text = {
                  { "󰒲 Lazy: ", hl = "footer" },
                  { status, hl = count > 0 and "special" or "footer" },
                },
              }
            end,
          },
          {
            function()
              local stats = require("lazy.stats").stats()
              local ms = math.floor(stats.startuptime * 100 + 0.5) / 100

              return {
                align = "center",
                text = {
                  { "⚡ Startzeit: ", hl = "footer" },
                  { ms .. " ms", hl = "special" },
                  { "  ·  ", hl = "footer" },
                  { stats.loaded .. "/" .. stats.count, hl = "special" },
                  { " Plugins geladen", hl = "footer" },
                },
              }
            end,
          },
        },
      },
      explorer = { enabled = true },
      input = { enabled = true },
      notifier = {
        enabled = true,
        width = { min = 50, max = 0.6 },
        height = { min = 1, max = 0.8 },
        style = "compact",
      },
      picker = {
        enabled = true,
        sources = {
          explorer = {
            jump = { close = true },
          },
        },
      },
      quickfile = { enabled = true },
      styles = {
        notification = {
          wo = {
            wrap = true,
          },
        },
      },
    },
    keys = {
      {
        "<leader><space>",
        function()
          Snacks.picker.smart()
        end,
        desc = "Dateien suchen",
      },
      {
        "<leader>ff",
        function()
          Snacks.picker.files()
        end,
        desc = "Dateien suchen",
      },
      {
        "<leader>fg",
        function()
          Snacks.picker.grep()
        end,
        desc = "Text suchen",
      },
      {
        "<leader>fb",
        function()
          Snacks.picker.buffers()
        end,
        desc = "Buffer suchen",
      },
      {
        "<leader>fr",
        function()
          Snacks.picker.recent()
        end,
        desc = "Letzte Dateien",
      },
      {
        "<leader>e",
        function()
          Snacks.explorer()
        end,
        desc = "Datei-Explorer",
      },
      {
        "<leader>nh",
        function()
          Snacks.notifier.show_history()
        end,
        desc = "Benachrichtigungsverlauf",
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    dependencies = { "neovim-treesitter/treesitter-parser-registry" },
    config = function()
      local languages = {
        "bash",
        "css",
        "dockerfile",
        "embedded_template",
        "go",
        "gomod",
        "gosum",
        "gowork",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "prisma",
        "query",
        "sql",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
      }
      require("nvim-treesitter").install(languages)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = languages,
        callback = function()
          pcall(vim.treesitter.start)
        end,
      })
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      current_line_blame = false,
      on_attach = function(bufnr)
        local gitsigns = require("gitsigns")
        local function map(lhs, rhs, desc)
          vim.keymap.set("n", lhs, rhs, { buffer = bufnr, desc = desc })
        end
        map("]h", gitsigns.next_hunk, "Nächste Git-Änderung")
        map("[h", gitsigns.prev_hunk, "Vorherige Git-Änderung")
        map("<leader>hp", gitsigns.preview_hunk, "Git-Änderung anzeigen")
        map("<leader>hb", gitsigns.blame_line, "Git-Blame für Zeile")
      end,
    },
  },
  {
    "brenoprata10/nvim-highlight-colors",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      render = "virtual",
      virtual_symbol = "■",
      virtual_symbol_position = "inline",
      enable_named_colors = true,
      enable_tailwind = false,
    },
  },
  {
    "laytan/tailwind-sorter.nvim",
    ft = { "html", "javascript", "javascriptreact", "typescript", "typescriptreact" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-lua/plenary.nvim",
    },
    build = "cd formatter && npm ci && npm run build",
    opts = {
      on_save_enabled = true,
      on_save_pattern = { "*.html", "*.js", "*.jsx", "*.ts", "*.tsx" },
      trim_spaces = true,
    },
    config = function(_, opts)
      -- tailwind-sorter still uses the parser API removed by newer
      -- nvim-treesitter versions. Neovim provides the same functionality
      -- through vim.treesitter now.
      local parsers = require("nvim-treesitter.parsers")
      parsers.get_parser = parsers.get_parser or function(...)
        local ok, parser = pcall(vim.treesitter.get_parser, ...)
        return ok and parser or nil
      end

      require("tailwind-sorter").setup(opts)
    end,
    keys = {
      { "<leader>ct", "<cmd>TailwindSort<cr>", desc = "Tailwind-Klassen sortieren" },
    },
  },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      enhanced_diff_hl = true,
      view = {
        merge_tool = { layout = "diff3_mixed" },
      },
    },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Git-Diff öffnen" },
      { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "Datei-Historie" },
      { "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "Repository-Historie" },
    },
  },
  {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "folke/snacks.nvim",
    },
    opts = {
      integrations = { diffview = true, snacks = true },
    },
    keys = {
      { "<leader>gg", "<cmd>Neogit kind=tab<cr>", desc = "Neogit" },
    },
  },
  { "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },
  { "windwp/nvim-ts-autotag", event = { "BufReadPre", "BufNewFile" }, opts = {} },
  {
    "folke/ts-comments.nvim",
    event = "VeryLazy",
    opts = {},
  },
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "folke/snacks.nvim" },
    opts = {},
    keys = {
      {
        "]t",
        function()
          require("todo-comments").jump_next()
        end,
        desc = "Nächster TODO-Kommentar",
      },
      {
        "[t",
        function()
          require("todo-comments").jump_prev()
        end,
        desc = "Vorheriger TODO-Kommentar",
      },
      { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "TODO-Kommentare" },
      { "<leader>xT", "<cmd>TodoSnacks<cr>", desc = "TODO-Kommentare suchen" },
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "modern",
      delay = 200,
      spec = {
        { "<leader>a", group = "AI" },
        { "<leader>c", group = "Code" },
        { "<leader>f", group = "Dateien/Suche" },
        { "<leader>g", group = "Git" },
        { "<leader>h", group = "Git-Änderungen" },
        { "<leader>n", group = "Benachrichtigungen" },
        { "<leader>p", group = "Plugins" },
        { "<leader>q", group = "Beenden" },
        { "<leader>r", group = "Tasks" },
        { "<leader>s", group = "Fenster teilen" },
        { "<leader>x", group = "Diagnosen" },
      },
    },
  },
  {
    "folke/trouble.nvim",
    cmd = { "Trouble" },
    opts = {},
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnosen" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer-Diagnosen" },
      { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbole" },
    },
  },
}
