return {
  -- Find, Filter, Preview, Pick. All lua, all the time.
  -- https://github.com/nvim-telescope/telescope.nvim
  "nvim-telescope/telescope.nvim",
  lazy = true,
  event = "VimEnter",
  branch = "0.1.x",
  dependencies = {
    -- plenary: full; complete; entire; absolute; unqualified. All the lua functions I don't want to write twice.
    -- https://github.com/nvim-lua/plenary.nvim
    "nvim-lua/plenary.nvim",

    -- lua `fork` of vim-web-devicons for neovim
    -- https://github.com/nvim-tree/nvim-web-devicons
    "nvim-tree/nvim-web-devicons",

    -- Extensions

    -- FZF sorter for telescope written in c
    -- https://github.com/nvim-telescope/telescope-fzf-native.nvim
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = function() return vim.fn.executable("make") == 1 end,
    },
    -- TailwindCSS cheatsheet within telescope
    -- https://github.com/danielvolchek/tailiscope.nvim
    "danielvolchek/tailiscope.nvim",
    -- Neovim plugin. Telescope.nvim extension that adds LuaSnip integration.
    -- https://github.com/benfowler/telescope-luasnip.nvim
    "benfowler/telescope-luasnip.nvim",
    -- Telescope extension that provides handy functionality about plugins installed via lazy.nvim
    -- https://github.com/tsakirist/telescope-lazy.nvim
    "tsakirist/telescope-lazy.nvim",
    -- A telescope extension to view and search your undo tree 🌴
    -- https://github.com/debugloop/telescope-undo.nvim
    "debugloop/telescope-undo.nvim",
  },
  config = function()
    local telescope = require("telescope")
    telescope.setup({
      extensions = {
        fzf = {
          fuzzy = true, -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
          case_mode = "smart_case", -- or "ignore_case" or "respect_case"
          -- the default case_mode is "smart_case"
        },
        undo = {
          use_delta = true,
          use_custom_command = nil, -- setting this implies `use_delta = false`. Accepted format is: { "bash", "-c", "echo '$DIFF' | delta" }
          side_by_side = true,
          layout_strategy = "vertical",
          diff_context_lines = vim.o.scrolloff,
          entry_format = "state #$ID, $STAT, $TIME",
          time_format = "",
          saved_only = false,
          layout_config = {
            preview_height = 0.8,
          },
        },
        lazy = {
          -- Whether or not to show the icon in the first column
          show_icon = true,
          -- Mappings for the actions
          mappings = {
            open_in_browser = "<C-o>",
            open_in_file_browser = "<M-b>",
            open_in_find_files = "<C-f>",
            open_in_live_grep = "<C-g>",
            open_in_terminal = "<C-t>",
            open_plugins_picker = "<C-b>", -- Works only after having called first another action
            open_lazy_root_find_files = "<C-r>f",
            open_lazy_root_live_grep = "<C-r>g",
            change_cwd_to_plugin = "<C-c>d",
          },
          -- Extra configuration options for the actions
          actions_opts = {
            open_in_browser = {
              -- Close the telescope window after the action is executed
              auto_close = false,
            },
            change_cwd_to_plugin = {
              -- Close the telescope window after the action is executed
              auto_close = false,
            },
          },
          -- Configuration that will be passed to the window that hosts the terminal
          -- For more configuration options check 'nvim_open_win()'
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
        luasnip = {
          search = function(entry)
            local lst = require("telescope").extensions.luasnip
            local luasnip = require("luasnip")
            return lst.filter_null(entry.context.trigger)
              .. " "
              .. lst.filter_null(entry.context.name)
              .. " "
              .. entry.ft
              .. " "
              .. lst.filter_description(
                entry.context.name,
                entry.context.description
              )
              .. lst.get_docstring(luasnip, entry.ft, entry.context)[1]
          end,
        },
        tailiscope = {
          -- register to copy classes to on selection
          register = "a",
          -- indicates what picker opens when running Telescope tailiscope
          -- can be any file inside of docs dir but most useful opts are
          -- all, base, categories, classes
          -- These are also accesible by running Telescope tailiscope <picker>
          default = "base",
          -- icon indicates an item which can be opened in tailwind docs
          -- can be icon or false
          doc_icon = " ",
          -- if you would prefer to copy with/without class selector
          -- dot is maintained in display to differentiate class from other pickers
          no_dot = true,
          maps = {
            i = {
              back = "<C-h>",
              open_doc = "<C-o>",
            },
            n = {
              back = "b",
              open_doc = "od",
            },
          },
        },
      },
    })

    -- Load extensions
    pcall(telescope.load_extension, "fzf")
    pcall(telescope.load_extension, "luasnip")
    pcall(telescope.load_extension, "lazy")
    pcall(telescope.load_extension, "undo")

    local builtin = require("telescope.builtin")

    -- Mappings
    vim.keymap.set(
      "n",
      "<leader>ff",
      builtin.find_files,
      { desc = "Find Files" }
    )
    vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
    vim.keymap.set(
      "n",
      "<leader><space>",
      builtin.buffers,
      { desc = "Search open Buffers" }
    )
    vim.keymap.set(
      "n",
      "<leader>fr",
      builtin.oldfiles,
      { desc = "Find recent Files" }
    )
    vim.keymap.set(
      "n",
      "<leader>fk",
      builtin.keymaps,
      { desc = "Find keymaps" }
    )
    vim.keymap.set(
      "n",
      "<leader>fo",
      function()
        builtin.live_grep({
          grep_open_files = true,
          prompt_title = "Live Grep in Open Files",
        })
      end,
      { desc = "Search in Open Files" }
    )
    vim.keymap.set(
      "n",
      "<leader>ft",
      ":TodoTelescope<CR>",
      { desc = "Show Todos" }
    )
    vim.keymap.set(
      "n",
      "<leader>xt",
      ":TodoTrouble",
      { desc = "Open Todos in Trouble" }
    )
    vim.keymap.set(
      "n",
      "<leader>fs",
      function()
        builtin.current_buffer_fuzzy_find(
          require("telescope.themes").get_dropdown({
            winblend = 10,
            previewer = false,
          })
        )
      end,
      { desc = "Fuzzy search in current buffer" }
    )
    vim.keymap.set(
      "n",
      "<leader>fl",
      "<cmd>Telescope luasnip<cr>",
      { desc = "Find LuaSnip" }
    )
    vim.keymap.set(
      "n",
      "<leader>fz",
      "<cmd>Telescope lazy<cr>",
      { desc = "Search Lazy" }
    )
    vim.keymap.set(
      "n",
      "<leader>fu",
      "<cmd>Telescope undo<cr>",
      { desc = "Search Undotree" }
    )
  end,
}
