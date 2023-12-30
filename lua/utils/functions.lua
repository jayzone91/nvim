local M = {}

---Shortcode for mapping
---@param mode string | table
---@param key string
---@param func function | string
---@param desc string | nil
---@return nil
M.map = function(mode, key, func, desc)
  return vim.keymap.set(mode, key, func, { desc = desc })
end

return M
