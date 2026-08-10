local M = {}

local function todo_comment()
  local bufnr = vim.api.nvim_get_current_buf()
  local row = vim.api.nvim_win_get_cursor(0)[1]
  local line = vim.api.nvim_buf_get_lines(bufnr, row - 1, row, false)[1] or ""
  local start_col, _, comment = line:find("(TODO:.*)")

  if not start_col then
    return
  end

  -- Avoid offering the action for TODO-like text inside strings when a parser is available.
  local ok, node = pcall(vim.treesitter.get_node, {
    bufnr = bufnr,
    pos = { row - 1, start_col - 1 },
  })
  if ok and node then
    while node and not node:type():find("comment", 1, true) do
      node = node:parent()
    end
    if not node then
      return
    end
  end

  return comment
end

function M.send_todo()
  local comment = todo_comment()
  if not comment then
    vim.notify("Kein Kommentar gefunden, der mit TODO: beginnt", vim.log.levels.WARN)
    return
  end

  local filename = vim.api.nvim_buf_get_name(0)
  if filename == "" then
    vim.notify("Die Datei muss vor dem Senden gespeichert werden", vim.log.levels.WARN)
    return
  end

  local prompt = table.concat({
    ("Please implement the code as described by the comment on %s"):format(filename),
    "",
    "The comment is:",
    comment,
    "",
    "Replace the comment with your implementation.",
    "Optimize for speed. Don't over-explore or over-check your work other than what is absolutely necessary to implement the comment.",
    "Once you are done, remove the comment.",
  }, "\n")

  require("sidekick.cli").send({
    name = "codex",
    msg = prompt,
    submit = true,
  })
end

function M.code_action()
  if not todo_comment() then
    vim.lsp.buf.code_action()
    return
  end

  local choices = {
    { label = "TODO mit Codex implementieren", run = M.send_todo },
    { label = "LSP-Code-Aktionen…", run = vim.lsp.buf.code_action },
  }

  vim.ui.select(choices, {
    prompt = "Code-Aktion",
    format_item = function(item)
      return item.label
    end,
  }, function(choice)
    if choice then
      choice.run()
    end
  end)
end

return M
