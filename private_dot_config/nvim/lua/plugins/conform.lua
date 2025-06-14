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
    -- https://github.com/stevearc/conform.nvim?tab=readme-ov-file#formatters
    formatters_by_ft = {
      css    = { "biome" },
      fish   = { "fish_indent" },
      json   = { "biome" },
      just   = { "just" },
      lua    = { "stylua" },
      nix    = { "alejandra" },
      python = { "ruff_fix", "ruff_format" },
      rust   = { "rustfmt", lsp_format = "fallback" },
      sh     = { "shfmt" },
      xml    = { "xmlformatter" },
    },
  },
}
