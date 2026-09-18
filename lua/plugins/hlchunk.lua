return {
  "shellRaining/hlchunk.nvim",
  enabled = false,
  event = { "BufReadPre", "BufNewFile" },
  ---@type HlChunk.UserConf
  opts = {
    indent = {
      enable = true,
    },
    chunk = {
      enable = true,
    },
  },
}
