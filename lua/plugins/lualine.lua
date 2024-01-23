return {
  "nvim-lualine/lualine.nvim",
  lazy = true,
  event = "VeryLazy",
  opts = {
    options = {
      theme = "catppuccin",
    },
    sections = {
      lualine_a = {
        function()
          return ""
        end,
        "mode",
      },
      lualine_x = {
        "filetype",
        function()
          local msg = "No Lsp"
          local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
          local clients = vim.lsp.get_active_clients()
          if next(clients) == nil then
            return msg
          end
          for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
              return client.name
            end
          end
          return msg
        end,
        function()
          local win = "󰨡"
          local mac = ""
          local other = ""
          local msg = ""
          if vim.fn.has("win32") == 1 then
            msg = win
          elseif vim.fn.has("macunix") == 1 then
            msg = mac
          else
            msg = other
          end
          return msg
        end,
      },
    },
  },
}
