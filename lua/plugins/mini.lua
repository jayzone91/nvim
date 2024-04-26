return {
  -- Collection of various small independent plugins/modules
  "echasnovski/mini.nvim",
  config = function()
    -- Better Around/inside textobjects
    require("mini.ai").setup({ n_lines = 500 })

    -- add/delete/replace surroundings (brackets, quotes, etc.)
    require("mini.surround").setup()

    -- Simple and easy statusline
    -- local statusline = require("mini.statusline")
    -- statusline.setup({ use_icons = true })
    -- statusline.section_location = function() return "%21:%-2v" end
  end,
}
