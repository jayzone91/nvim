local function explorer_action(action)
  vim.schedule(function()
    local picker = _G.SnacksExplorerPicker

    if picker and not picker.closed then
      picker:action(action)
    end
  end)
end

_G.SnacksExplorerAction = explorer_action

local function setup_explorer_context_menu()
  ---@diagnostic disable-next-line: param-type-mismatch
  pcall(vim.cmd, [[aunmenu ]SnacksExplorer]])

  vim.cmd([[
    anoremenu ]SnacksExplorer.New
      \ <Cmd>lua _G.SnacksExplorerAction("explorer_add")<CR>
  ]])

  vim.cmd([[
    anoremenu ]SnacksExplorer.Rename
      \ <Cmd>lua _G.SnacksExplorerAction("explorer_rename")<CR>
  ]])

  vim.cmd([[anoremenu ]SnacksExplorer.-1- <Nop>]])

  vim.cmd([[
    anoremenu ]SnacksExplorer.Copy
      \ <Cmd>lua _G.SnacksExplorerAction("explorer_yank")<CR>
  ]])

  vim.cmd([[
    anoremenu ]SnacksExplorer.Paste
      \ <Cmd>lua _G.SnacksExplorerAction("explorer_paste")<CR>
  ]])

  vim.cmd([[anoremenu ]SnacksExplorer.-2- <Nop>]])

  vim.cmd([[
    anoremenu ]SnacksExplorer.Delete
      \ <Cmd>lua _G.SnacksExplorerAction("explorer_del")<CR>
  ]])
end

setup_explorer_context_menu()

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    dashboard = {
      enabled = true,

      preset = {
        header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
]],

        keys = {
          {
            icon = "󰒲 ",
            key = "s",
            desc = "Restore Session",
            section = "session",
          },
          {
            icon = " ",
            key = "f",
            desc = "Find File",
            action = function()
              Snacks.picker.files()
            end,
          },
          {
            icon = " ",
            key = "r",
            desc = "Recent Files",
            action = function()
              Snacks.picker.recent()
            end,
          },
          {
            icon = "󰱼 ",
            key = "g",
            desc = "Grep Project",
            action = function()
              Snacks.picker.grep()
            end,
          },
          {
            icon = " ",
            key = "e",
            desc = "Explorer",
            action = function()
              Snacks.explorer()
            end,
          },
          {
            icon = " ",
            key = "t",
            desc = "Terminal",
            action = function()
              Snacks.terminal()
            end,
          },
          {
            icon = " ",
            key = "n",
            desc = "New File",
            action = ":ene | startinsert",
          },
          {
            icon = " ",
            key = "q",
            desc = "Quit",
            action = ":qa",
          },
        },
      },

      sections = {
        {
          section = "header",
          padding = 1,
        },

        function()
          local cwd = vim.fn.getcwd()
          local project = vim.fn.fnamemodify(cwd, ":t")

          local branch = vim.fn.systemlist("git branch --show-current")[1] or ""
          local changes = vim.fn.systemlist("git status --porcelain")
          local changed = #changes

          local git = ""

          if vim.v.shell_error == 0 and branch ~= "" then
            git = ("   %s"):format(branch)

            if changed > 0 then
              git = git .. ("  •  %d changed"):format(changed)
            end
          end

          return {
            {
              text = {
                {
                  "󰉋 " .. project,
                  hl = "SnacksDashboardTitle",
                },
              },
              align = "center",
            },
            {
              text = {
                {
                  cwd,
                  hl = "SnacksDashboardDesc",
                },
              },
              align = "center",
            },
            {
              text = {
                {
                  git,
                  hl = "SnacksDashboardDesc",
                },
              },
              align = "center",
              padding = 1,
            },
          }
        end,

        {
          icon = " ",
          title = "Git Status",
          section = "terminal",

          enabled = function()
            return Snacks.git.get_root() ~= nil
          end,

          cmd = "git status --short --branch --renames",
          height = 6,
          padding = 1,
          ttl = 5,
          indent = 3,
        },

        {
          icon = " ",
          title = "Actions",
          section = "keys",
          gap = 1,
          padding = 1,
        },

        {
          section = "startup",
        },
      },
    },
    bigfile = { enabled = true },
    explorer = { enabled = true },
    input = { enabled = true },
    notifier = { enabled = true, timeout = 3000 },
    picker = {
      enabled = true,
      actions = {
        sidekick_send = function(...)
          return require("sidekick.cli.picker.snacks").send(...)
        end,
        explorer_context = function(picker)
          local mouse = vim.fn.getmousepos()

          if mouse.winid == picker.list.win.win then
            vim.api.nvim_win_set_cursor(mouse.winid, {
              mouse.line,
              math.max(mouse.column - 1, 0),
            })
          end

          _G.SnacksExplorerPicker = picker

          vim.cmd("popup! ]SnacksExplorer")
        end,
      },
      win = {
        input = {
          keys = {
            ["<A-a>"] = {
              "sidekick_send",
              mode = { "n", "i" },
            },
          },
        },
      },
      sources = {
        explorer = {
          layout = {
            preset = "sidebar",
            layout = {
              position = "left",
              width = 32,
            },
          },
          auto_close = false,
          follow_file = true,
          tree = true,
          hidden = true,
          ignored = false,
          win = {
            list = {
              keys = {
                ["<CR>"] = "confirm",
                ["<leader>h"] = "edit_split",
                ["<leader>v"] = "edit_vsplit",
                ["<RightMouse>"] = "explorer_context",
              },
            },
          },
        },
      },
    },
    quickfile = { enabled = true },
    rename = { enabled = true },
    terminal = { enabled = true },
    words = { enabled = true },
  },
  keys = {
    {
      "<C-p>",
      function()
        Snacks.picker.files()
      end,
      desc = "Quick Open",
    },
    {
      "<leader>ff",
      function()
        Snacks.picker.files()
      end,
      desc = "Search Files",
    },
    {
      "<C-S-p>",
      function()
        Snacks.picker.commands()
      end,
      desc = "Command Palette",
    },
    {
      "<C-S-f>",
      function()
        Snacks.picker.grep()
      end,
      desc = "Search in Files",
    },
    {
      "<leader>fg",
      function()
        Snacks.picker.grep()
      end,
      desc = "Live Grep",
    },
    {
      "<leader>t",
      function()
        Snacks.terminal()
      end,
      desc = "Terminal",
    },
    {
      "<leader>fr",
      function()
        Snacks.picker.recent()
      end,
      desc = "Recent Files",
    },
    {
      "<leader>fb",
      function()
        Snacks.picker.buffers()
      end,
      desc = "Open Buffers",
    },
    {
      "<leader><space>",
      function()
        Snacks.picker.buffers()
      end,
      desc = "Open Buffers",
    },
    {
      "<C-b>",
      function()
        Snacks.explorer()
      end,
      desc = "Explorer",
    },
    {
      "<leader>e",
      function()
        Snacks.explorer()
      end,
      desc = "Explorer",
    },
    {
      "<leader>cr",
      function()
        Snacks.picker.lsp_references()
      end,
      desc = "References",
    },
    {
      "<leader>cd",
      function()
        Snacks.picker.lsp_definitions()
      end,
      desc = "Definitions",
    },
    {
      "<leader>ci",
      function()
        Snacks.picker.lsp_implementations()
      end,
      desc = "Implementations",
    },
    {
      "<leader>ct",
      function()
        Snacks.picker.lsp_type_definitions()
      end,
      desc = "Type Definitions",
    },
    {
      "<leader>cs",
      function()
        Snacks.picker.lsp_symbols()
      end,
      desc = "Document Symbols",
    },
    {
      "<leader>cS",
      function()
        Snacks.picker.lsp_workspace_symbols()
      end,
      desc = "Workspace Symbols",
    },
    {
      "<A-n>",
      function()
        Snacks.words.jump(vim.v.count1)
      end,
      desc = "Next Reference",
    },
    {
      "<A-p>",
      function()
        Snacks.words.jump(-vim.v.count1)
      end,
      desc = "Previous Reference",
    },
    {
      "<leader>xd",
      function()
        Snacks.picker.diagnostics()
      end,
      desc = "Diagnostics",
    },
    {
      "<leader>xD",
      function()
        Snacks.picker.diagnostics_buffer()
      end,
      desc = "Buffer Diagnostics",
    },
    -- Git
    {
      "<leader>gb",
      function()
        Snacks.picker.git_branches()
      end,
      desc = "Git Branches",
    },
    {
      "<leader>gl",
      function()
        Snacks.picker.git_log()
      end,
      desc = "Git Log",
    },
    {
      "<leader>gf",
      function()
        Snacks.picker.git_log_file()
      end,
      desc = "Git File History",
    },
    {
      "<leader>gS",
      function()
        Snacks.picker.git_status()
      end,
      desc = "Git Status",
    },
    {
      "<leader>gd",
      function()
        Snacks.picker.git_diff()
      end,
      desc = "Git Diff",
    },
    {
      "<leader>gT",
      function()
        Snacks.picker.git_stash()
      end,
      desc = "Git Stash",
    },
    {
      "<leader>.",
      function()
        Snacks.scratch()
      end,
      desc = "scratch buffer",
    },
    {
      "<leader>wm",
      function()
        Snacks.zen.zoom()
      end,
      desc = "Zoom Window",
    },
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        Snacks.toggle.inlay_hints():map("<leader>ch")
        Snacks.toggle({
          name = "Toggle Codelens",
          get = function()
            return vim.lsp.codelens.is_enabled({ bufnr = 0 })
          end,
          set = function(enabled)
            vim.lsp.codelens.enable(enabled, { bufnr = 0 })
          end,
        }):map("<leader>cc")
        Snacks.toggle({
          name = "Toggle Linked Editing",
          get = function()
            return vim.lsp.linked_editing_range.is_enabled({ bufnr = 0 })
          end,
          set = function(enabled)
            vim.lsp.linked_editing_range.enable(enabled, { bufnr = 0 })
          end,
        }):map("<leader>ce")
      end,
    })
  end,
}
