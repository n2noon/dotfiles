return {
  "saghen/blink.cmp",
  dependencies = {
    "rafamadriz/friendly-snippets",
    -- "saghen/blink.compat"
  },
  version = "*",
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      preset = "super-tab",
      ["<C-E>"] = { "show_and_insert" },
    },
    completion = {
      documentation = { auto_show = true, auto_show_delay_ms = 500 },
      -- ghost_text = { enabled = true },
    },
    sources = {
      default = { "lazydev", "snippets", "lsp", "path", "buffer" },
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          -- make lazydev completions top priority (see `:h blink.cmp`)
          score_offset = 100,
        },
      },
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
