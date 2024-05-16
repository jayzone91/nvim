local test_telescope, telescope = pcall(require, "telescope")
if not test_telescope then return end

telescope.setup({
  defaults = {
    path_display = { "smart" },
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
      wrap_results = true,
    },
  },
})

pcall(require("telescope").load_extension, "fzf")
pcall(require("telescope").load_extension, "smart_history")

local builtin = require("telescope.builtin")

-- Mappings
local map = function(mode, key, func, desc)
  vim.keymap.set(mode, key, func, { desc = desc })
end

map("n", "<leader>ff", builtin.find_files, "Find Files")
map("n", "<leader><space>", builtin.buffers, "Search open Buffers")
map("n", "<leader>fr", builtin.oldfiles, "Find recent Files")
map("n", "<leader>fk", builtin.keymaps, "Find Keymaps")
map("n", "<leader>fo", function()
builtin.live_grep({
  grep_open_files = true,
  prompt_title = "Live Grep in Open Files",
}) end, "Search in open Files")
map("n", "<leader>ft", ":TodoTelescope<CR>", "Show Todos")
map("n", "<leader>xt", ":TodoTrouble<CR>", "Open Todos in Trouble")
map("n", "<leader>fs", function()
  builtin.current_buffer_fuzzy_find(
    require("telescope.themes").get_dropdown({
      winblend = 10,
      previewer = false,
    }))
  end, "Fuzzy Search in Current Buffer")
map("n", "<leader>fg", builtin.live_grep, "Live Grep")
map("n", "<leader>fc", function()
  builtin.find_files({ cwd = vim.fn.stdpath("config")})
end, "Search Config")
map("n", "<leader>fa", function()
  builtin.find_files({ cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy")})
end, "Find ... Lazy")
