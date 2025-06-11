return {
  "MeanderingProgrammer/render-markdown.nvim",
  lazy = true,
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "echasnovski/mini.nvim",
  },
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    completions = { blink = { enabled = true } },
    heading = {
      -- icons = { "", "", "", "", "", "" },
      -- width = "block",
      -- right_pad = 2,
      -- backgrounds = { "", "", "", "", "", "" },
      enabled = false,
    },
  },
}
