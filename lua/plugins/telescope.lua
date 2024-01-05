local map = require("utils.functions").map

return {
  {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
    },
    config = function()
      require("telescope").setup({
        defaults = {
          mappings = {
            i = {
              ["<C-u>"] = false,
              ["<C-d>"] = false,
            },
          },
        },
      })
      -- Enable telescope fzf native, if installed
      pcall(require("telescope").load_extension, "fzf")

      -- Telescope live_grep in git root
      -- Function to find the git root directory based on the current buffer's path

      local builtin = require("telescope.builtin")
      map("n", "<leader>?", builtin.oldfiles, "[?] Find recently opened files")
      map("n", "<leader>ff", builtin.find_files, "[f] Find Files")
      map("n", "<leader>fg", builtin.live_grep, "[g] Live Grep")
      map("n", "<leader><space>", builtin.buffers, "[ ] Find existing buffers")
      map(
        "n",
        "<leader>fb",
        builtin.current_buffer_fuzzy_find,
        "[b] Fuzzily search in current buffer"
      )

      map("n", "<leader>gf", builtin.git_files, "Search [G]it [F]iles")

      -- Enable Telescope Noice Support, if installed
      local testNoice = pcall(require("telescope").load_extension, "noice")
      if testNoice then
        map("n", "<leader>fn", "<cmd>Noice telescope<cr>", "Show noice")
      end

      local telescope = require("telescope")
      -- Enable Telescope Trouble Support, if installed
      local test, trouble = pcall(require, "trouble.providers.telescope")
      if test then
        telescope.setup({
          defaults = {
            mappings = {
              i = { ["<c-t>"] = trouble.open_with_trouble },
              n = { ["<c-t>"] = trouble.open_with_trouble },
            },
          },
        })
      end
    end,
  },
}
