--[[
--Fluoromachine is a fork of the popular Synthwave84 color
--scheme, which is inspired by the aesthetics of the 1980s
--and the retro-futuristic genre known as synthwave.
--Fluoromachine (Colorscheme) incorporates this
--neon-drenched style into its design, with a glowing
--effect that adds a touch of sci-fi to your coding experience.
--]]
-- https://github.com/maxmx03/fluoromachine.nvim?tab=readme-ov-file

return {
  "maxmx03/fluoromachine.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    local fm = require("fluoromachine")

    fm.setup({
      ---@type boolean
      glow = true,
      ---@type number
      brightness = 0.05,
      ---@type string
      theme = "delta",
      ---@type boolean | "full"
      transparent = true,
    })
  end,
}
