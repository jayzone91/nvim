return {
  "danymat/neogen",
  cmd = "Neogen",
  ---@module "neogen"
  ---@type neogen.Configuration
  opts = {
    snippet_engine = "nvim",
  },
  keys = {
    {
      "<leader>cn",
      function()
        require("neogen").generate()
      end,
      desc = "Generate Annotation",
    },
  },
}
