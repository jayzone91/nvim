return {
  "NvChad/nvim-colorizer.lua",
  event = "VeryLazy",
  opts = {
    user_default_options = {
      tailwind = true,
    },
  },
  config = function(_, opts)
    require("colorizer").setup(opts)
    require("colorizer").attach_to_buffer(0)
  end,
}
