vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("jay_lsp_attach", { clear = true }),
  callback = function(event)
    local function map(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, { buffer = event.buf, silent = true, desc = desc })
    end

    map("gd", vim.lsp.buf.definition, "Zur Definition")
    map("gD", vim.lsp.buf.declaration, "Zur Deklaration")
    map("gr", vim.lsp.buf.references, "Referenzen")
    map("gI", vim.lsp.buf.implementation, "Zur Implementierung")
    map("K", vim.lsp.buf.hover, "Dokumentation")
    map("<leader>ca", require("config.code_actions").code_action, "Code-Aktion")
    map("<leader>cr", vim.lsp.buf.rename, "Symbol umbenennen")
    map("<leader>co", function()
      vim.lsp.buf.code_action({
        apply = true,
        context = { only = { "source.organizeImports" }, diagnostics = {} },
      })
    end, "Imports organisieren")
    map("<leader>cF", function()
      local ok = pcall(vim.cmd, "LspEslintFixAll")
      if not ok then
        vim.notify("ESLint ist für diesen Buffer nicht verfügbar", vim.log.levels.WARN)
      end
    end, "Alle ESLint-Probleme beheben")
    map("<leader>cd", vim.diagnostic.open_float, "Zeilendiagnose")
    map("]d", function()
      vim.diagnostic.jump({ count = 1, float = true })
    end, "Nächste Diagnose")
    map("[d", function()
      vim.diagnostic.jump({ count = -1, float = true })
    end, "Vorherige Diagnose")

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
      vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
    end
  end,
})
