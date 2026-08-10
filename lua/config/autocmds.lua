local function augroup(name)
  return vim.api.nvim_create_augroup("jay_" .. name, { clear = true })
end

local autocmd = vim.api.nvim_create_autocmd

autocmd("InsertEnter", {
  desc = "Hide relative linenumbers",
  group = augroup("hide_relative_numbers"),
  callback = function()
    vim.o.relativenumber = false
  end,
})

autocmd("InsertLeave", {
  desc = "Show relative linenumbers",
  group = augroup("show_relative_numbers"),
  callback = function()
    vim.o.relativenumber = true
  end,
})

vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  desc = "Check if we need to reload the file when it changed",
  group = augroup("checktime"),
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight on Yank",
  group = augroup("highlight_yank"),
  callback = function()
    (vim.hl or vim.highlight).on_yank()
  end,
})

vim.api.nvim_create_autocmd({ "VimResized" }, {
  desc = "Resize splits if window got resized",
  group = augroup("resize_split"),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  desc = "Close some filetypes with <q>",
  group = augroup("close_with_q"),
  pattern = {
    "PlenaryTestPopup",
    "checkhealth",
    "dap-float",
    "dbout",
    "gitsigns-blame",
    "grug-far",
    "help",
    "lspinfo",
    "neotest-output",
    "neotest-output-panel",
    "neotest-summary",
    "notify",
    "qf",
    "spectre_panel",
    "startuptime",
    "tsplayground",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.schedule(function()
      vim.keymap.set("n", "q", function()
        vim.cmd("close")
        pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
      end, {
        buffer = event.buf,
        silent = true,
        desc = "Quit Buffer",
      })
    end)
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  desc = "Make it easier to close man-files when opened inline",
  group = augroup("man_unlisted"),
  pattern = { "man" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
  end,
})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  desc = "Auto create dir when saving a file",
  group = augroup("auto_create_dir"),
  callback = function(event)
    if event.match:match("^%w%w+:[\\/][\\/]") then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  desc = "Disable commenting next line",
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove({ "r", "o" })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  desc = "Enable spell checking only for prose",
  group = augroup("spell_prose"),
  pattern = { "gitcommit", "markdown", "mdx", "text" },
  callback = function()
    vim.opt_local.spell = true
  end,
})

vim.api.nvim_create_autocmd("BufReadPre", {
  desc = "Syntaxhighlighting for dotenv files",
  group = augroup("dotenv"),
  pattern = { ".env", ".env.*" },
  callback = function()
    vim.bo.filetype = "disini"
  end,
})

---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
local lsp_progress = vim.defaulttable()

vim.api.nvim_create_autocmd("LspProgress", {
  desc = "Show LSP progress with Snacks",
  group = augroup("lsp_progress"),
  ---@param event {data: {client_id: integer, params: lsp.ProgressParams}}
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    local value = event.data.params.value
    --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
    if not client or type(value) ~= "table" then
      return
    end

    local progress = lsp_progress[client.id]
    for index = 1, #progress + 1 do
      if index == #progress + 1 or progress[index].token == event.data.params.token then
        progress[index] = {
          token = event.data.params.token,
          msg = ("[%3d%%] %s%s"):format(
            value.kind == "end" and 100 or value.percentage or 100,
            value.title or "",
            value.message and (" **%s**"):format(value.message) or ""
          ),
          done = value.kind == "end",
        }
        break
      end
    end

    local messages = {} ---@type string[]
    lsp_progress[client.id] = vim.tbl_filter(function(item)
      return table.insert(messages, item.msg) or not item.done
    end, progress)

    local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
    vim.notify(table.concat(messages, "\n"), "info", {
      id = "lsp_progress",
      title = client.name,
      opts = function(notification)
        notification.icon = #lsp_progress[client.id] == 0 and " "
          or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
      end,
    })
  end,
})
