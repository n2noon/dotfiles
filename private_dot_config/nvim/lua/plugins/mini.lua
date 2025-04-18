return {
  "echasnovski/mini.nvim",
  version = false,
  priority = 1000,
  -- lazy = false,
  config = function()
    -- q is for quotes
    -- b is for brackets
    -- ? is custom
    require("mini.ai").setup()
    require("mini.align").setup()
    -- require("mini.bracketed").setup()
    -- require('mini.clue').setup()
    -- do things like swapping words
    require("mini.operators").setup({
      evaluate = {
        prefix = "t=",
      },
      exchange = {
        prefix = "tx",
      },
      multiply = {
        prefix = "tm",
      },
      replace = {
        prefix = "tr",
        reindent_linewise = true,
      },
      sort = {
        prefix = "ts",
      },
    })
    -- require("mini.git").setup()
    require("mini.pairs").setup()
    require("mini.splitjoin").setup({ mappings = { toggle = "gj" } })
    -- saiw' adds ' to word surrounding
    -- ds' deletes '
    -- cs'" changes
    -- fs finds
    -- sh highlights
    -- can use q and b also
    require("mini.surround").setup()
    ---@module "mini.statusline"
    require("mini.statusline").setup({
      use_icons = false,
      content = {},
    })
    -- require('mini.sessions').setup()
  end,
}
