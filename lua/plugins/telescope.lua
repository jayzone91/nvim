return {
  -- Find, Filter, Preview, Pick. All lua, all the time.
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  event = "VeryLazy",
  dependencies = {
    -- plenary: full; complete; entire; absolute; unqualified.
    -- All the lua functions I don't want to write twice.
    "nvim-lua/plenary.nvim",
    {
      -- FZF sorter for telescope written in c
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = vim.fn.executable "make" == 1
    }
  },
  config = function()
    local actions = require("telescope.actions")

    require("telescope").setup({
      defaults = {
        -- Default configuration for telescope goes here:
        -- config_key = value,
        mappings = {
          i = {
            -- map actions.which_key to <C-h> (default: <C-/>)
            -- actions.which_key shows the mappings for your picker,
            -- e.g. git_{create, delete, ...}_branch for the git_branches picker
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            ["<C-x>"] = actions.delete_buffer,
          },
        },
        pickers = {
          -- Default configuration for builtin pickers goes here:
          -- picker_name = {
          --   picker_config_key = value,
          --   ...
          -- }
          -- Now the picker_config_key will be applied every time you call this
          -- builtin picker
        },
        extensions = {
          -- Your extension configuration goes here:
          -- extension_name = {
          --   extension_config_key = value,
          -- }
          -- please take a look at the readme of the extension you want to configure
          fzf = {
            fuzzy = true,                   -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
            case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
          }
        },
        file_ignore_patterns = {
          "node_modules",
          "yarn.lock",
          ".git",
          ".sl",
          "_build",
          ".next",
          ".target",
        },
        hidden = true,
      },
    })

    pcall(require("telescope").load_extension, "fzf")
    local builtin = require("telescope.builtin")
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
  end,
}
