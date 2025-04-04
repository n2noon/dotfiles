return {
  {
    -- see https://github.com/folke/snacks.nvim?tab=readme-ov-file#-usage
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      dashboard = {
        enabled = true,
        -- row = 5
        preset = {
          -- header = [[]]
          keys = {
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "y", desc = "Yazi", action = ":Yazi" }, -- TODO - this properly
            {
              icon = " ",
              key = "c",
              desc = "Config",
              action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
            },
            -- { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            -- { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            -- { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
        sections = {
          { section = "keys", gap = 1 },
          { icon = " ", section = "recent_files", indent = 2, padding = 2 },
          { section = "startup" },
        },
      },
      -- debug = { enabled = true },
      -- lazygit = { enabled = true },
      quickfile = { enabled = true },
      rename = { enabled = true },
      scope = { enabled = true },
      -- scratch = { enabled = true },
      statuscolumn = { enabled = true },
      -- terminal = { enabled = true },
      -- toggle = { enabled = true },
    },
    keys = require("keymaps").snacks,
  },
  {
    "echasnovski/mini.nvim",
    version = false,
    priority = 1000,
    -- lazy = false,
    config = function()
      -- allows for q as a quote object and b selects all brackets
      require("mini.ai").setup()
      -- require('mini.clue').setup() needs triggers
      -- require('mini.pairs').setup()
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
  },
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = require("keymaps").fzflua,
    opts = {
      -- see https://github.com/ibhagwan/fzf-lua?tab=readme-ov-file#customization
      defaults = {
        file_icons = false,
        winopts = {
          height = 0.95,
          width = 0.93,
          border = "double",
          preview = { title_pos = "left" },
        },
      },
      -- VSCode-like file name first
      files = {
        formatter = "path.filename_first",
        winopts = {},
      },
      blines = { previewer = false, winopts = { row = 0.4, height = 0.9, width = 0.8 } },
      oldfiles = {
        formatter = "path.filename_first",
        include_current_session = true,
      },
      code_actions = {
        -- requires git-delta
        previewer = "codeaction_native",
      },
      lsp = {
        -- see https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#symbolKind
        symbols = {
          symbol_style = 2,
          symbol_fmt = function(s) return s end,
        },
      },
    },
  },
  -- {
  --   'smoka7/hop.nvim',
  --   event = 'BufRead',
  --   version = "*",
  --   opts = {
  --       keys = 'asdfqwertyghjkluiopvbnm'
  --   },
  --   keys = {
  --       {'<leader>h', '<cmd>HopAnywhere<cr>', desc = '[H]op'}
  --
  --   },
  -- },
  {
    "mikavilpas/yazi.nvim",
    -- event = 'VeryLazy',
    priority = 1000,
    lazy = false,
    opts = {
      -- instead of netrw
      open_for_directories = true,
      keymaps = {
        show_help = "±", -- TODO: this
        open_file_in_horizontal_split = "<c-s>",
      },
      integrations = {
        grep_in_directory = "fzf-lua",
      },
      yazi_floating_window_winblend = 0,
    },
    keys = require("keymaps").yazi,
  },
  -- TODO: do this https://github.com/epwalsh/obsidian.nvim/issues/770#issuecomment-2557300925
  {
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
  },
  {
    "folke/todo-comments.nvim",
    event = "VimEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { signs = false },
    keys = require("keymaps").todocomments,
  },
  {
    "kawre/leetcode.nvim",
    cmd = "Leet",
    build = "TSUpdate html",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "ibhagwan/fzf-lua",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    opts = { lang = "java" },
  },
  -- {
  --   "OXY2DEV/markview.nvim",
  --   lazy = false,
  -- },
  {
    "https://gitlab.com/Biggybi/nvim-smartcd.git",
    event = { "BufEnter" },
    lazy = false,
    opts = { create_keymaps = true },
    cmd = { "SmartCd" },
    keys = require("keymaps").smartcd,
  },
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    -- ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    event = {
      -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
      -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
      -- refer to `:h file-pattern` for more examples
      "BufReadPre "
        .. vim.fn.expand("~")
        .. "/Notes/notes/*.md",

      "BufNewFile " .. vim.fn.expand("~") .. "/Notes/notes",
    },
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",
    },
    opts = {
      workspaces = {
        {
          name = "Notes",
          path = "~/Notes",
        },
      },
    },
  },
}
