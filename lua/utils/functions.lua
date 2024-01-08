local M = {}

---Shortcode for mapping
---@param mode string | table the mode
---@param key string keystroke
---@param func function | string function, command or keystroke
---@param desc string | nil desription of mapping, displays inside "whichkey"
---@return nil return a new mapping
M.map = function(mode, key, func, desc)
  return vim.keymap.set(mode, key, func, { desc = desc })
end

function M.cowboy()
  ---@type table?
  local id
  local ok = true
  for _, key in ipairs({ "h", "j", "k", "l", "+", "-" }) do
    local count = 0
    local timer = assert(vim.loop.new_timer())
    local map = key
    vim.keymap.set("n", key, function()
      if vim.v.count > 0 then
        count = 0
      end
      if count >= 10 then
        ok, id = pcall(vim.notify, "Hold it Cowboy!", vim.log.levels.WARN, {
          icon = "🤠",
          replace = id,
          keep = function()
            return count >= 10
          end,
        })
        if not ok then
          id = nil
          return map
        end
      else
        count = count + 1
        timer:start(2000, 0, function()
          count = 0
        end)
        return map
      end
    end, { expr = true, silent = true })
  end
end

return M
