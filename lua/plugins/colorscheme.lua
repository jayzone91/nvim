return {
  {
    name = "vscode-2026",
    dir = vim.fn.stdpath("config"),
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("vscode-2026")
    end,
  },
}
