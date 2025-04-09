return {
  -- see https://github.com/folke/snacks.nvim?tab=readme-ov-file#-usage
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    dashboard = {
      enabled = true,
      -- row = 5
      preset = {
        -- header = [[]]
        keys = {
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep_native')" },
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
    -- debug = { enabled = true },
    -- lazygit = { enabled = true },
    quickfile = { enabled = true },
    rename = { enabled = true },
    scope = { enabled = true },
    -- scratch = { enabled = true },
    statuscolumn = { enabled = true },
    -- terminal = { enabled = true },
    -- toggle = { enabled = true },
  },
  keys = require("keymaps").snacks,
}
