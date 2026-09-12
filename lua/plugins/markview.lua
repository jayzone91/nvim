return {
  "OXY2DEV/markview.nvim",
  ft = { "markdown", "mdx" },
  ---@module "markview"
  ---@return markview.config
  opts = function()
    require("markview.extras.editor").setup()
    local presets = require("markview.presets")
    ---@type markview.config
    return {
      markdown = {
        enable = true,
        headings = presets.headings.slanted,
        horizontal_rules = presets.horizontal_rules.thin,
        tables = presets.tables.rounded,
        block_quotes = presets.block_quotes.obsidian,
      },
      markdown_inline = {
        tags = {
          default = {
            hl = "MarkviewCodeInfo",
            padding_left = "",
            padding_left_hl = "MarkviewCodeFg",
            padding_right = "",
            padding_right_hl = "MarkviewCodeFg",
          },
          enable = true,
        },
      },
    }
  end,
}
