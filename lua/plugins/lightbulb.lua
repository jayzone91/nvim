return {
  "kosayoda/nvim-lightbulb",
  event = "LspAttach",
  ---@module "nvim-lightbulb"
  ---@type nvim-lightbulb.Config
  opts = {
    autocmd = {
      enabled = true,
    },
    sign = {
      enabled = true,
      text = "󰌵",
    },
    status_text = {
      enabled = true,
      text = "󰌵",
    },
  },
}
