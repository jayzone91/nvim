return {
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
    {
      "nvim-telescope/telescope-file-browser.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
    },
  },
  config = function()
    local map = function(m, k, f, d)
      return vim.keymap.set(m, k, f, { desc = d })
    end
    require("telescope").setup({
      extensions = {
        file_browser = {
          hijack_netrw = true,
          grouped = true,
          select_buffer = true,
        },
      },
      defaults = {
        theme = "center",
        sorting_strategy = "ascending",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_height = 0.3,
          },
        },
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
    -- Enable telescope file Briowser Plugin
    pcall(require("telescope").load_extension, "file_browser")

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
    map(
      "n",
      "<leader>e",
      "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr><esc>",
      "Open File Browser"
    )

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
}
