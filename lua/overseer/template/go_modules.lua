---@type overseer.TemplateFileProvider
return {
  cache_key = function()
    return vim.fn.getcwd()
  end,
  generator = function()
    if vim.fn.executable("go") == 0 then
      return "Go ist nicht im PATH verfügbar"
    end

    local modules = vim.fn.globpath(vim.fn.getcwd(), "workflows/*/go.mod", false, true)
    local tasks = {}
    for _, go_mod in ipairs(modules) do
      local cwd = vim.fs.dirname(go_mod)
      local name = vim.fs.basename(cwd)
      for _, task in ipairs({
        { action = "build", args = { "build", "./..." } },
        { action = "test", args = { "test", "./..." } },
        { action = "run", args = { "run", "." } },
      }) do
        tasks[#tasks + 1] = {
          name = ("go %s (%s)"):format(task.action, name),
          builder = function()
            return {
              cmd = "go",
              args = task.args,
              cwd = cwd,
            }
          end,
        }
      end
    end
    return tasks
  end,
}
