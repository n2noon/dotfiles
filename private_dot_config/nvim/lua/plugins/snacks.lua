---@module "snacks.nvim"
return {
  -- see https://github.com/folke/snacks.nvim?tab=readme-ov-file#-usage
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = {},
    dashboard = {
      preset = {
        keys = {
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('grep')" },
          { icon = " ", key = "y", desc = "Yazi", action = ":Yazi" }, -- TODO - this properly
          {
            icon = " ",
            key = "c",
            desc = "Config",
            action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
          },
          -- { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          -- { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          -- { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
      sections = {
        { section = "keys", gap = 1 },
        { icon = " ", section = "recent_files", indent = 2, padding = 2 },
        { section = "startup" },
      },
    },
    -- debug = {},
    -- lazygit = {},
    quickfile = {},
    -- rename = {},
    scope = {},
    -- scratch = {},
    picker = {
      layout = {
        preset = "sidebar",
      },
      -- layouts = {
      --
      --
      -- }
      win = {
        input = {
          keys = {
            ["<Esc>"] = { "close", mode = { "n", "i" } },
            ["<c-p>"] = { "preview_scroll_up", mode = { "i", "n" } },
            ["<c-n>"] = { "preview_scroll_down", mode = { "i", "n" } },
          },
        },
      },
      -- layouts = {
      --   { "wider-sidebar", preset = "sidebar", layout = { width = 0.6 } },
      -- },
      ---@type Snacks.picker.formatters.Config
      formatters = {
        file = { filename_first = true },
      },
      previewers = { diff = { builtin = false }, git = { builtin = false } },
      sources = {
        diagnostics = {
          layout = "ivy_split",
        },
        diagnostics_buffer = {
          layout = "ivy_split",
        },
        git_branches = {
          layout = "ivy_split",
        },
        git_log = {
          layout = "ivy_split",
        },
        git_log_line = {
          layout = "ivy_split",
        },
        git_log_file = {
          layout = "ivy_split",
        },
        grep = {
          layout = "ivy_split",
        },
        grep_buffers = {
          layout = "ivy_split",
        },
        grep_word = {
          layout = "ivy_split",
        },
        qflist = {
          layout = "ivy_split",
        },
        registers = {
          layout = "vscode",
        },
      },
      icons = { files = { enabled = false } },
    },
    statuscolumn = {},
    terminal = {},
    -- toggle = {},
    -- words = {}
  },
  keys = require("keymaps").snacks,
}
