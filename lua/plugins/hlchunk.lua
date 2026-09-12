return {
  "shellRaining/hlchunk.nvim",
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
