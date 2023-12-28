return {
  "echasnovski/mini.hipatterns",
  version = false,
  event = "BufReadPre",
  config = function()
    local hi = require("mini.hipatterns")
    hi.setup({
      highlighter = {
        hsl_color = {
          pattern = "hsl%(%d+,? %d+,? %d+%)",
          group = function(_, match)
            local utils = require("utils.hsl")
            local h, s, l = match:match("hsl%((%d+),? (%d+),? (%d+)%)")
            h, s, l = tonumber(h), tonumber(s), tonumber(l)
            if h == nil then
              return
            end
            if s == nil then
              return
            end
            if l == nil then
              return
            end
            local hex_color = utils.hslToHex(h, s, l)
            return MiniHipatterns.compute_hex_color_group(hex_color, "bg")
          end,
        },
        hex_colors = hi.gen_highlighter.hex_color(),
      },
    })
  end,
}
