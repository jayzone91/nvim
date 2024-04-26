return {
  "nvim-telescope/telescope.nvim",
  event = "VimEnter",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = function() return vim.fn.executable("make") == 1 end,
    },
    "nvim-telescope/telescope-ui-select.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("telescope").setup({
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown(),
        },
      },
    })

    pcall(require("telescope").load_extension, "fzf")
    pcall(require("telescope").load_extension, "ui-select")

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
      "<leader>fc",
      "<CMD>Telescope colorscheme<CR>",
      { desc = "Find Colorscheme" }
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
      "<leader>/",
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
  end,
}
