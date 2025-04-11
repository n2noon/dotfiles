--  NOTE: options come before plugins (keep leader key binding)
require("options")
require("keymaps").init()
require("autocmds")

----- LAZY -----
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then error("Error cloning lazy.nvim:\n" .. out) end
end
vim.opt.rtp:prepend(lazypath)

vim.api.nvim_set_hl(0, "SnacksPickerDir", { fg = "#928374" })
vim.api.nvim_set_hl(0, "SnacksPickerPathHidden", { fg = "#928374" })
vim.api.nvim_set_hl(0, "SnacksDashboardDir", { fg = "#928374" })
vim.api.nvim_set_hl(0, "SnacksPickerBufFlags", { fg = "#928374" })
vim.api.nvim_set_hl(0, "SnacksPickerPathIgnored", { fg = "#928374" })
vim.api.nvim_set_hl(0, "SnacksPickerGitStatusIgnored", { fg = "#928374" })
vim.api.nvim_set_hl(0, "SnacksPickerGitStatusUntracked", { fg = "#928374" })

-- Configure plugins.
---@type Lazy
require("lazy").setup("plugins", {
  -- ui = { border = "rounded" },
  -- dev = { path = vim.g.projects_dir },
  install = {
    -- Do not automatically install on startup.
    missing = false,
  },
  -- This gets annoying when editing plugins
  change_detection = { notify = false },
  -- I don't use luarocks
  rocks = {
    enabled = false,
  },
  performance = {
    rtp = {
      -- Stuff I don't use.
      disabled_plugins = {
        "gzip",
        "netrwPlugin",
        "rplugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
