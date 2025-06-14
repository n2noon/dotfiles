notes_dir = vim.fn.expand("~/Notes")
projects_dir = vim.fn.expand("~/Projects")

---@module 'snacks'
---@type snacks.dashboard.Config
dashboard = {
  preset = {
    keys = {
      { icon = " ", key = "n", desc = "New",    action = ":ene | startinsert" },
      { icon = " ", key = "p", desc = "File",   action = ":lua Snacks.dashboard.pick('files')" },
      { icon = " ", key = "f", desc = "Text",   action = ":lua Snacks.dashboard.pick('grep')" },
      { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})", },
      { icon = "󰎚 ", key = "N", desc = "Notes",  action = ":lua Snacks.dashboard.pick('files', {cwd = notes_dir})" },
    },
  },
  sections = {
    { section = "keys", gap = 1, padding = 1 },
    { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy", padding = 1, pane = 2, enabled = package.loaded.lazy ~= nil, },
    { icon = " ", key = "m", desc = "Mason", action = ":Mason", padding = 1, pane = 2 },
    { icon = " ", key = "y", desc = "Yazi", action = ":Yazi", padding = 1, pane = 2 },
    { icon = " ", key = "<tab>", desc = "Recent", action = ":lua Snacks.dashboard.pick('oldfiles')" },
    { icon = " ", indent = 2, section = "recent_files", padding = 2 },
    { icon = " ", key = "P", desc = "Projects", action = ":lua Snacks.dashboard.pick('files', {cwd = projects_dir})", pane = 2, },
    { icon = " ", indent = 2, section = "projects", padding = 2, pane = 2 },
    { section = "startup" },
  },
}

return dashboard
