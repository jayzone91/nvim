return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim", -- All the lua functions I don't want to write twice.
    "BurntSushi/ripgrep",    -- is required for live_grep and grep_string and is the first priority for find_files.

    -- Telescope Plugins
    {
      -- Native FZF sorter that uses compiled C to do the matching, supports fzf syntax
      -- Make sure you have 'make' installed. On Windows install with scoop!
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
    -- Find emojis😃
    "xiyaowong/telescope-emoji.nvim",
    -- Lazy integration
    "tsakirist/telescope-lazy.nvim",
  },
  config = function()
    local builtin = require("telescope.builtin")

    -- Setup Telescope
    require("telescope").setup({
      defaults = {
        file_ignore_patterns = {
          "node_modules",
          "%.git/",
          "%.DS_STORE$",
          "target",
          "build",
          "%.o$",
        },
        color_devicons = true,
      },
      extensions = {
        fzf = {
          fuzzy = true, -- false will only do exact matching
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
        lazy = {
          theme = "dropdown",
          show_icon = true,
          mappings = {
            open_in_find_files = "<C-f>",
            open_in_live_grep = "<C-g>",
            open_lazy_root_find_files = "<C-r>f",
            open_lazy_root_live_grep = "<C-r>g",
          },
          terminal_opts = {
            relative = "editor",
            style = "minimal",
            border = "rounded",
            title = "Telescope lazy",
            title_pos = "center",
            width = 0.5,
            height = 0.5,
          },
        },
        emoji = {
          action = function(emoji)
            vim.api.nvim_put({ emoji.value }, "c", false, true)
          end,
        },
      },
    })

    -- initiallize Plugins
    -- using pcall to make sure the plugin is installed correctly.
    pcall(require("telescope").load_extension, "fzf")
    pcall(require("telescope").load_extension, "emoji")
    pcall(require("telescope").load_extension, "lazy")

    -- Telescope Keybinds
    vim.keymap.set(
      "n",
      "<leader>ff",
      builtin.find_files,
      { desc = "Find Files" }
    )
    vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
    vim.keymap.set(
      "n",
      "<leader>fb",
      builtin.current_buffer_fuzzy_find,
      { desc = "Live fuzzy search inside of the currently open buffer" }
    )
    vim.keymap.set(
      "n",
      "<leader><space>",
      builtin.buffers,
      { desc = "Show all open Buffers" }
    )
    vim.keymap.set(
      "n",
      "<leader>fq",
      builtin.quickfix,
      { desc = "Lists items in the quickfix list" }
    )
    vim.keymap.set(
      "n",
      "<leader>flr",
      builtin.lsp_references,
      { desc = "Lists LSP references for word under the cursor" }
    )
    vim.keymap.set(
      "n",
      "<leader>fli",
      builtin.lsp_implementations,
      { desc = "Goto the implementation of the word under the cursor" }
    )
    vim.keymap.set(
      "n",
      "<leader>fld",
      builtin.lsp_definitions,
      { desc = "Goto the definition of the word under the cursor" }
    )

    -- Telescope Plugins Keybinds
    vim.keymap.set(
      "n",
      "<leader>fp",
      "<cmd>Telescope lazy<cr>",
      { desc = "Show Lazy Plugins" }
    )
    vim.keymap.set(
      "n",
      "<leader>fe",
      "<cmd>Telescope emoji<cr>",
      { desc = "Search emojis😃" }
    )
  end,
}
