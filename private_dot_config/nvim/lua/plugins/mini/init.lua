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
    require("mini.align").setup({
      mappings = {
        start = 'ga',
        start_with_preview = 'gA',
      },
    })

    ----------------------------- operators ----------------------------
    -- Evaluate text and replace with output.
    -- Exchange text regions.
    -- Multiply (duplicate) text.
    -- Replace text with register.
    -- Sort text.
    require("mini.operators").setup({
      evaluate = { prefix = "<leader>=" },
      exchange = { prefix = "<leader>x" },
      multiply = { prefix = "tm" },
      sort     = { prefix = "so" },
      replace  = { prefix = "<leader>p", reindent_linewise =  true, },
    })
    require("mini.pairs").setup()
    require("mini.splitjoin").setup({ mappings = { toggle = "gj" } })
    -- saiw' adds ' to word surrounding
    -- ds' deletes '
    -- cs'" changes
    -- fs finds
    -- sh highlights
    -- can use q and b also
    require("mini.diff").setup()
    require("mini.surround").setup()
    local statusline = function()
      local git = MiniStatusline.section_git({ trunc_width = 40 })
      local diff = MiniStatusline.section_diff({ trunc_width = 75 })
      local lsp = MiniStatusline.section_lsp({ trunc_width = 75 })
      local filename = MiniStatusline.section_filename({ trunc_width = 140 })
      local diagnostics   = MiniStatusline.section_diagnostics({ trunc_width = 75 })
      -- local fileinfo = MiniStatusline.section_fileinfo({
      --   trunc_width = 120,
      --
      -- })
      -- local location = MiniStatusline.section_location({ trunc_width = 9999 })
      -- local search = MiniStatusline.section_searchcount({ trunc_width = 75 })

      return MiniStatusline.combine_groups({
        { hl = "MiniStatuslineDevinfo", strings = { git, diff, lsp } },
        "%<", -- Mark general truncate point
        { hl = "MiniStatuslineFilename", strings = { filename } },
        "%=", -- End left alignment
        { hl = "MiniStatuslineFileinfo", strings = { diagnostics } },
        -- { hl = mode_hl, strings = { search } },
      })
    end
    ---@module "mini.statusline"
    require("mini.statusline").setup({
      -- use_icons = false,
      content = { active = statusline },
    })
    -- require('mini.sessions').setup()
  end,
}
