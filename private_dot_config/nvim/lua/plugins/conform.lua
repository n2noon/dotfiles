return {
  "stevearc/conform.nvim",
  -- see https://github.com/stevearc/conform.nvim/issues/192
  dependencies = { "mason.nvim" },
  -- lazy = true,
  cmd = "ConformInfo",
  keys = require("keymaps").conform,
  opts = {
    format_on_save = {
      -- I recommend these options. See :help conform.format for details.
      lsp_format = "fallback",
      timeout_ms = 500,
    },
    formatters_by_ft = require("lsp").formatters_by_ft,
    formatters = require("lsp").formatters,
  },
}
