return {
  "stevearc/conform.nvim",
  -- see https://github.com/stevearc/conform.nvim/issues/192
  dependencies = { "mason.nvim" },
  -- lazy = true,
  cmd = "ConformInfo",
  keys = require("keymaps").conform,
  ---@module 'conform.nvim'
  ---@type conform.setupOpts
  opts = {
    format_after_save = {
      lsp_format = "fallback",
    },
    formatters_by_ft = require("lsp").formatters_by_ft,
    formatters = require("lsp").formatters,
  },
}
