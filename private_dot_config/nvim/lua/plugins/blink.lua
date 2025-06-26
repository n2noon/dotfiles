-- https://cmp.saghen.dev/configuration/general.html
-- FIXME: dictionary boolean toggle
M = {
  "saghen/blink.cmp",
  dependencies = {
    "rafamadriz/friendly-snippets",
    "mikavilpas/blink-ripgrep.nvim",
    -- "saghen/blink.compat"
    "folke/snacks.nvim",
  },
  version = "*",
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      preset = "super-tab",
      ["<C-E>"] = { "show_and_insert" },
      ["<C-F>"] = { function() require("blink-cmp").show({ providers = { "ripgrep" } }) end },
      ["<C-D>"] = { function() require("blink-cmp").show() end },
      ["<C-N>"] = { "scroll_documentation_down" },
      ["<C-P>"] = { "scroll_documentation_up" },
    },
    completion = {
      documentation = { auto_show = true, auto_show_delay_ms = 500 },
    },
    sources = {
      default = {
        "lazydev",
        "snippets",
        "lsp",
        "path",
        "buffer",
      },
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          -- make lazydev completions top priority (see `:h blink.cmp`)
          score_offset = 10,
        },
        ripgrep = {
          module = "blink-ripgrep",
          name = "Ripgrep",
          -- the options below are optional, some default values are shown
          ---@module "blink-ripgrep"
          ---@type blink-ripgrep.Options
          opts = {
            project_root_marker = { ".git", "package.json", "Cargo.toml", "pyproject.toml", ".svn" },
            future_features = {
              backend = {
                use = "gitgrep-or-ripgrep",
              },
            },
          },
        },
        snippets = {
          score_offset = 2,
        },
        buffer = {
          max_items = 1500,
        },
      },
      min_keyword_length = function(ctx)
        -- don't complete commands < 2 chars long
        return (vim.bo.filetype == "markdown" or ctx.mode == "cmdline") and 3 or 0
        -- if ctx.mode == 'cmdline' and string.find(ctx.line, ' ') == nil then return 2 end
        -- return 0
      end,
    },
    signature = { enabled = false },
  },
  opts_extend = { "sources.default" },
}
return M
