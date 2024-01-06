local map = require("utils.functions").map

return {
  "nvim-pack/nvim-spectre",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "BurntSushi/ripgrep",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local spec = require("spectre")
    spec.setup({})

    map("n", "<leader>S", function()
      spec.toggle()
    end, "Toggle Spectre")

    map("n", "<leader>sw", function()
      spec.open_visual({ select_word = true })
    end, "Search current word")

    map(
      "v",
      "<leader>sw",
      "<esc><cmd>lua require('spectre').open_visual()<cr>",
      "Search current word"
    )

    map("n", "<leader>sp", function()
      spec.open_file_search({ select_word = true })
    end, "Search on current file")
  end,
}
