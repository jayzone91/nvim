return {
  "ThePrimeagen/harpoon",
  lazy = true,
  event = "BufEnter",
  branch = "harpoon2",
  dependencies = "nvim-lua/plenary.nvim",
  config = function()
    local map = function(m, k, f, d)
      return vim.keymap.set(m, k, f, { desc = d })
    end
    local harpoon = require("harpoon")
    harpoon:setup({})

    -- toggle files with telescope
    local conf = require("telescope.config").values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require("telescope.pickers")
          .new({}, {
            prompt_title = "Harpoon",
            finder = require("telescope.finders").new_table({
              results = file_paths,
            }),
            previewer = conf.file_previewer({}),
            sorter = conf.generic_sorter({}),
          })
          :find()
    end

    map("n", "<leader>fe", function()
      toggle_telescope(harpoon:list())
    end, "Open Harpoon")

    -- basic mappings
    map("n", "<c-e>", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, "Open Harpoon")
    map("n", "<leader>a", function()
      harpoon:list():append()
    end, "Add file to Harpoon")
    map("n", "<leader>1", function()
      harpoon:list():select(1)
    end, "GOTO first file in Harpoon list.")
    map("n", "<leader>2", function()
      harpoon:list():select(2)
    end, "GOTO first file in Harpoon list.")
    map("n", "<leader>3", function()
      harpoon:list():select(3)
    end, "GOTO first file in Harpoon list.")
    map("n", "<leader>4", function()
      harpoon:list():select(4)
    end, "GOTO first file in Harpoon list.")
  end,
}
