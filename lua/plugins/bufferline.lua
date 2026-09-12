local function open_context_menu(bufnr)
  vim.cmd("buffer " .. bufnr)
  vim.cmd("popup! ]BufferLine")
end

local function setup_context_menu()
  pcall(vim.cmd, [[aunmenu ]BufferLine]])

  vim.cmd([[
    anoremenu ]BufferLine.Close
      \ <Cmd>lua Snacks.bufdelete(vim.api.nvim_get_current_buf())<CR>
  ]])

  vim.cmd([[
    anoremenu ]BufferLine.Close\ Others
      \ <Cmd>BufferLineCloseOthers<CR>
  ]])

  vim.cmd([[
    anoremenu ]BufferLine.Close\ Left
      \ <Cmd>BufferLineCloseLeft<CR>
  ]])

  vim.cmd([[
    anoremenu ]BufferLine.Close\ Right
      \ <Cmd>BufferLineCloseRight<CR>
  ]])
end

setup_context_menu()

return {
  "akinsho/bufferline.nvim",
  version = "*",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    options = {
      diagnostics = "nvim_lsp",
      diagnostic_update_in_insert = false,
      show_close_icon = false,
      close_command = function(bufnr)
        Snacks.bufdelete(bufnr)
      end,
      right_mouse_command = function(bufnr)
        open_context_menu(bufnr)
      end,
      offsets = {
        {
          filetype = "snacks_picker_list",
          text = "Explorer",
          text_align = "left",
          separator = true,
        },
      },
    },
  },
  keys = {
    { "<Tab>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
    { "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", desc = "Previous Buffer" },
    {
      "<C-w>",
      function()
        Snacks.bufdelete()
      end,
      desc = "Close Buffer",
    },
    {
      "<leader>bo",
      "<cmd>BufferLineCloseOthers<cr>",
      desc = "Close Other Buffers",
    },
    {
      "<leader>br",
      "<cmd>BufferLineCloseRight<cr>",
      desc = "Close Buffers Right",
    },
    {
      "<leader>bl",
      "<cmd>BufferLineCloseLeft<cr>",
      desc = "Close Buffers Left",
    },
  },
}
