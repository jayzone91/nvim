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

return M
