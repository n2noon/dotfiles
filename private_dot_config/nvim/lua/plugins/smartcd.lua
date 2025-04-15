return {
  "https://gitlab.com/Biggybi/nvim-smartcd.git",
  enabled = false,
  event = { "BufEnter" },
  lazy = false,
  opts = { create_keymaps = true },
  cmd = { "SmartCd" },
  keys = require("keymaps").smartcd,
}
