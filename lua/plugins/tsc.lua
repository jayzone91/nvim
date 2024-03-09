return {
  -- A Neovim plugin for seamless, asynchronous project-wide
  -- TypeScript type-checking using the TypeScript compiler (tsc)
  "dmmulroy/tsc.nvim",
  lazy = false,
  fr = { "typescript", "typescriptreact" },
  config = function()
    require("tsc").setup({
      auto_open_qflist = true,
      auto_close_qflist = false,
      auto_focus_qflist = false,
      auto_start_watch_mode = false,
      enable_progress_notifications = true,
      hide_progress_notifications_from_history = true,
      spinner = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" },
      pretty_errors = true,
    })
  end
}
