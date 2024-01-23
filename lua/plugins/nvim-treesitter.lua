return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = true,
    event = "BufEnter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    build = ":TSUpdate",
    config = function()
      vim.defer_fn(function()
        require("nvim-treesitter.configs").setup({
          -- Add languages to be installed here.
          ensure_installed = {
            "c",
            "lua",
            "vim",
            "vimdoc",
            "query",
            "javascript",
            "html",
            "typescript",
            "tsx",
            "dockerfile",
            "fish",
            "json",
            "markdown",
            "php",
            "python",
            "regex",
            "toml",
            "css",
            "prisma",
            "scss",
            "sql",
          },
          -- Autoinstall languages that are not installed. On Windows requires Admin Rights
          auto_install = true,
          ignore_install = {},
          modules = {},
          sync_install = false,
          highlight = { enable = true },
          indent = { enable = true },
          incremental_selection = {
            enable = true,
            keymaps = {
              init_selection = "<c-space>",
              node_incremental = "<c-space>",
              scope_incremental = "<c-s>",
              node_decremental = "<M-space>",
            },
          },
          textobjects = {
            select = {
              enable = true,
              lookahead = true, -- Automatically jump forward to textonj, similar to targets.vim
              keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["aa"] = "@parameter.outer",
                ["ia"] = "@parameter.inner",
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
              },
            },
            move = {
              enable = true,
              set_jumps = true, -- whether to set jumps in the jumplist
              goto_next_start = {
                ["]m"] = "@function.outer",
                ["]]"] = "@class.outer",
              },
              goto_next_end = {
                ["]M"] = "@function.outer",
                ["]["] = "@class.outer",
              },
              goto_previous_start = {
                ["[m"] = "@function.outer",
                ["[["] = "@class.outer",
              },
              goto_previous_end = {
                ["[M"] = "@function.outer",
                ["[]"] = "@class.outer",
              },
            },
          },
        })
      end, 0)
    end,
  },
}
