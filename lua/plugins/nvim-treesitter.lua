return {
  -- Nvim Treesitter configurations and abstraction layer
  -- Warning: Treesitter and nvim-treesitter highlighting are
  -- an experimental feature of Neovim. Please consider
  -- the experience with this plug-in as experimental
  -- until Tree-Sitter support in Neovim is stable!
  -- We recommend using the nightly builds of Neovim
  -- if possible. The roadmap and all features of this
  -- plugin are open to change, and any suggestion will be
  -- highly appreciated!
  "nvim-treesitter/nvim-treesitter",
  build = function()
    require("nvim-treesitter.install").update({ with_sync = true })
  end,
  event = { "BufEnter" },
  dependencies = {
    -- Syntax aware text-objects, select, move, swap, and peek support.
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require("nvim-treesitter.configs").setup({
      -- A list of parser names, or "all"
      -- (the five listed parsers should always be installed)
      ensure_installed = {
        "bash",
        "c", -- should be installed
        "css",
        "html",
        "javascript",
        "json",
        "lua", -- should be installed
        "markdown",
        "prisma",
        "tsx",
        "typescript",
        "vim",    -- should be installed
        "vimdoc", -- should be installed
        "query"   -- should be installed
      },
      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = true,
      -- Automatically install missing parsers when entering buffer
      -- Recommendation: set to false if you don't have
      -- `tree-sitter` CLI installed locally
      auto_install = true,
      -- List of parsers to ignore installing (or "all")
      ignore_install = {},
      ---- If you need to change the installation directory of the parsers
      ---- (see -> Advanced Setup)
      -- Remember to run
      -- vim.opt.runtimepath:append("/some/path/to/store/parsers")!
      -- parser_install_dir = "/some/path/to/store/parsers",
      highlight = {
        enable = true,
        -- NOTE: these are the names of the parsers and not the filetype.
        -- (for example if you want to
        -- disable highlighting for the `tex` filetype, you need to
        -- include `latex` in this list as this is
        -- the name of the parser)
        -- list of language that will be disabled
        disable = {},
        -- Or use a function for more flexibility, e.g. to disable slow
        -- treesitter highlight for large files
        -- disable = function(lang, buf)
        --   local max_filesize = 100 * 1024 -- 100 KB
        --   local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        --   if ok and stats and stats.size > max_filesize then
        --     return true
        --   end
        -- end,

        -- Setting this to true will run `:h syntax` and tree-sitter at
        -- the same time.
        -- Set this to `true` if you depend on 'syntax' being
        -- enabled (like for indentation).
        -- Using this option may slow down your editor,
        -- and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
      autopairs = { enable = true, },
      autotag = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-Space>",
          node_incremental = "<C-Space>",
          scope_incremental = "<C-s>",
          node_decremental = "<C-Backspace>",
        }
      },
      text_objects = {
        select = {
          enable = true,
          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,
        }
      }
    })
  end,
}
