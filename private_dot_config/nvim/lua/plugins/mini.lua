return {
  "echasnovski/mini.nvim",
  version = false,
  priority = 1000,
  -- lazy = false,
  config = function()
    -- allows for q as a quote object and b selects all brackets
    require("mini.ai").setup()
    -- require('mini.clue').setup() needs triggers
    require("mini.pairs").setup()
    -- gj splits or joins
    require("mini.splitjoin").setup({ mappings = { toggle = "gj" } })
    -- saiw' adds ' to word surrounding
    -- ds' deletes '
    -- cs'" changes
    -- fs finds
    -- sh highlights
    -- can use q and b also
    require("mini.surround").setup()
    -- require('mini.sessions').setup()
  end,
}
