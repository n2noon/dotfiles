return {
  "mikavilpas/yazi.nvim",
  -- event = 'VeryLazy',
  priority = 1000,
  lazy = false,
  ---@module "yazi"
  ---@type YaziConfig
  opts = {
    -- instead of netrw
    open_for_directories = true,
    keymaps = {
      show_help = "±", -- TODO: this
      open_file_in_horizontal_split = "<c-s>",
    },
    integrations = {
      -- grep_in_directory = "fzf-lua",
      grep_in_directory = "snacks.picker",
    },
    yazi_floating_window_winblend = 0,
  },
  keys = require("keymaps").yazi,
}
