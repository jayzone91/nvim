return {
  "catgoose/nvim-colorizer.lua",
  event = "BufReadPre",
  opts = {
    options = {
      parsers = {
        tailwind = { enabled = true },
      },
    },
  },
}
