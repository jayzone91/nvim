local function expect(condition, message)
  if not condition then
    error(message, 0)
  end
end

local lazy_config = require("lazy.core.config")
local plugin = require("lazy.core.plugin")

for _, name in ipairs({
  "windsurf.nvim",
  "flash.nvim",
  "quicker.nvim",
  "colorful-menu.nvim",
  "smear-cursor.nvim",
  "mini.animate",
}) do
  expect(lazy_config.plugins[name] ~= nil, "missing plugin: " .. name)
end

expect(
  lazy_config.plugins["windsurf.nvim"].main == "codeium",
  "windsurf main module"
)

local blink = plugin.values(lazy_config.plugins["blink.cmp"], "opts", false)
expect(
  blink.fuzzy.implementation == "prefer_rust_with_warning",
  "blink fuzzy matcher"
)
expect(
  vim.deep_equal(blink.fuzzy.sorts, { "exact", "score", "sort_text" }),
  "blink ranking"
)

local snacks = plugin.values(lazy_config.plugins["snacks.nvim"], "opts", false)
expect(snacks.scroll.enabled == true, "snacks smooth scroll")
expect(snacks.indent.enabled == true, "snacks animated indent")
expect(snacks.indent.animate.enabled == true, "snacks indent animation")

vim.cmd("enew")
vim.api.nvim_buf_set_lines(0, 0, -1, false, { "first", "last" })
vim.api.nvim_win_set_cursor(0, { 2, 0 })

local cursor_down = vim.fn.maparg("<C-S-Down>", "n", false, true).callback
expect(type(cursor_down) == "function", "missing multicursor mapping")
expect(pcall(cursor_down), "multicursor boundary")

vim.v.errmsg = ""
local transient = vim.api.nvim_create_buf(false, true)
vim.api.nvim_set_option_value("filetype", "qf", { buf = transient })
vim.api.nvim_buf_delete(transient, { force = true })
vim.wait(20)
expect(
  not vim.v.errmsg:find("Invalid buffer id", 1, true),
  "transient buffer race"
)

print("config_spec: ok")
