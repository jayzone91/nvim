return {
  -- A fancy, configurable, notification manager for NeoVim
  -- Make sure to use a font which supported glyphs (icons)
  -- 24-bit colour is required,
  -- which can be enabled by adding this to your init.lua
  "rcarriga/nvim-notify",
  event = "VeryLazy",
  config = function()
    vim.o.termguicolors = true
    local notify = require("notify")
    local filtered_message = { "No information available" }
    ---@diagnostic disable-next-line: missing-fields
    notify.setup({
      background_colour = "#000000",
      render = "wrapped-compact",
      max_width = 80,
      minimum_width = 50
    })
    -- Override notify function to filter out messages
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.notify = function(message, level, opts)
      local merged_opts = vim.tbl_extend("force", {
        on_open = function(win)
          local bud = vim.api.nvim_win_get_buf(win)
          ---@diagnostic disable-next-line: deprecated
          vim.api.nvim_buf_set_option(bud, "filetype", "markdown")
        end,
      }, opts or {})

      for _, msg in ipairs(filtered_message) do
        if message == msg then
          return
        end
      end
      return notify(message, level, merged_opts)
    end

    -- Update colors to use catppuccin colors
    vim.cmd([[
        highlight NotifyERRORBorder guifg=#ed8796
        highlight NotifyERRORIcon guifg=#ed8796
        highlight NotifyERRORTitle  guifg=#ed8796
        highlight NotifyINFOBorder guifg=#8aadf4
        highlight NotifyINFOIcon guifg=#8aadf4
        highlight NotifyINFOTitle guifg=#8aadf4
        highlight NotifyWARNBorder guifg=#f5a97f
        highlight NotifyWARNIcon guifg=#f5a97f
        highlight NotifyWARNTitle guifg=#f5a97f
      ]])
  end,
}
