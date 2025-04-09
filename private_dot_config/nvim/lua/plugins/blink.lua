return {
  "saghen/blink.cmp",
  dependencies = {
    "rafamadriz/friendly-snippets",
    -- "saghen/blink.compat"
  },
  version = "*",
  opts = {
    keymap = {
      preset = "super-tab",
    },
    completion = {
      documentation = { auto_show = true, auto_show_delay_ms = 500 },
      -- ghost_text = { enabled = true },
    },
    sources = {
      default = { "snippets", "lsp", "path", "buffer" },
      min_keyword_length = function(ctx)
        -- don't complete commands < 2 chars long
        return (vim.bo.filetype == "markdown" or ctx.mode == "cmdline") and 3 or 0
        -- if ctx.mode == 'cmdline' and string.find(ctx.line, ' ') == nil then return 2 end
        -- return 0
      end,
    },
    signature = { enabled = true },
  },
  opts_extend = { "sources.default" },
}
