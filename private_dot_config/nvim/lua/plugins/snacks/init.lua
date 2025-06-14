notes_dir = vim.fn.expand("~/Notes")
projects_dir = vim.fn.expand("~/Projects")

return {
  -- see https://github.com/folke/snacks.nvim?tab=readme-ov-file#-usage
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@module 'snacks'
  ---@type snacks.Config
  opts = {
    bigfile = { notify = false, line_length = 2000 },
    dashboard = require("plugins.snacks.dashboard"),
    gitbrowse = {},
    lazygit = {
      theme = {},
    },
    -- git = {},
    quickfile = {},
    -- rename = {},
    scope = {},
    -- scratch = {},
    picker = {
      layout = {
        preset = "sidebar",
      },
      input = {
        keys = {
          ["<Esc>"] = { "close", mode = { "n", "i" } },
          ["<c-p>"] = { "preview_scroll_up", mode = { "i", "n" } },
          ["<c-n>"] = { "preview_scroll_down", mode = { "i", "n" } },
          ["<a-c>"] = { "toggle_cwd", mode = { "n", "i" } },
        },
      },
      actions = {
        ---@param p snacks.Picker
        toggle_cwd = function(p)
          -- TODO: buggy
          local root = vim.fs.normalize(vim.fn.expand("%:p"))
          local cwd = vim.fs.normalize((vim.uv or vim.loop).cwd() or ".")
          local current = p:cwd()
          p:set_cwd(current == root and cwd or root)
          p:find()
        end,
      },
      -- layouts = {
      --   { "wider-sidebar", preset = "sidebar", layout = { width = 0.6 } },
      -- },
      formatters = {
        file = { filename_first = true },
      },
      previewers = { diff = { builtin = false }, git = { builtin = false } },
      sources = {
        diagnostics = {
          layout = "ivy_split",
        },
        diagnostics_buffer = {
          layout = "ivy_split",
        },
        files = {
          layout = "telescope",
        },
        git_branches = {
          layout = "ivy_split",
        },
        git_log = {
          layout = "ivy_split",
        },
        git_log_line = {
          layout = "left",
        },
        git_log_file = {
          layout = "left",
        },
        grep = {
          layout = "ivy_split",
        },
        grep_buffers = {
          layout = "ivy_split",
        },
        grep_word = {
          layout = "ivy_split",
        },
        qflist = {
          layout = "ivy_split",
        },
        registers = {
          layout = "vscode",
        },
        lsp_symbols = {
          layout = "right",
        },
      },
      icons = { files = { enabled = false } },
    },
  },
  statuscolumn = {},
  keys = require("keymaps").snacks,
}
