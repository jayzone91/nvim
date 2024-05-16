local lazystatus = require("lazy.status")
local lualine = require("lualine")

lualine.setup({
  options = {
    theme = "rose-pine",
  },
  sections = {
    lualine_x = {
      {
        lazystatus.updates,
        cond = lazystatus.has_updates,
      },
      { "encoding" },
      { "fileformat" },
      { "filetype" },
    },
  },
})
