return {
  "echasnovski/mini.nvim",
  version = false,
  priority = 1000,
  -- lazy = false,
  config = function()
    --------------------------------- ai -------------------------------
    -- q is for quotes
    -- b is for brackets
    -- ? is custom
    require("mini.ai").setup()
    ------------------------------- align ------------------------------
    -- Filter specifies which delimiter in the split we should work with
    --   (also makes it so trim doesn't affect everything after that)
    -- Split separates into array of delimiters and Words
    -- Merge adds... delimiters? Keep testing
    -- Justify... justifies
    -- Trim ignores whitespace when aligning
    -- Ignore ignores some stuff
    -- Pair smushes things together
    require("mini.align").setup()

    ----------------------------- operators ----------------------------
    -- Evaluate text and replace with output.
    -- Exchange text regions.
    -- Multiply (duplicate) text.
    -- Replace text with register.
    -- Sort text.
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
