return {
  {
    -- see https://github.com/folke/snacks.nvim?tab=readme-ov-file#-usage
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      dashboard = { enabled = true },
      debug = { enabled = true },
      lazygit = { enabled = true },
      quickfile = { enabled = true },
      rename = { enabled = true },
      scope = { enabled = true },
      scratch = { enabled = true },
      statuscolumn = { enabled = true },
      terminal = { enabled = true },
      toggle = { enabled = true },
    },
    keys = {
      { '<leader>g', function() Snacks.lazygit() end, desc = 'Lazygit', },
      { '<leader>..', function() Snacks.scratch() end, desc = 'Toggle Scratch Buffer', },
      { '<leader>.,', function() Snacks.scratch.select() end, desc = 'Select Scratch Buffer', },
      { '<leader>N', function() Snacks.rename.rename_file() end, desc = 'Rename File', },
      { "<c-'>", function() Snacks.terminal() end, desc = 'Toggle Terminal', },
      { '<leader>§', function() Snacks.terminal() end, desc = 'Toggle Terminal', },
    },
  },
  {
    'echasnovski/mini.nvim',
    version = false,
    priority = 1000,
    lazy = false,
    config = function ()
      -- allows for q as a quote object and b selects all brackets
      require('mini.ai').setup()
      -- require('mini.clue').setup() needs triggers
      require('mini.pairs').setup()
      -- gj splits or joins
      require('mini.splitjoin').setup({mappings = {toggle = 'gj'}})
      -- saiw' adds ' to word surrounding
      -- ds' deletes '
      -- cs'" changes
      -- fs finds
      -- sh highlights
      -- can use q and b also
      require('mini.surround').setup()
      -- require('mini.sessions').setup()
    end
  },
  {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = {
      { '<c-p>', function() FzfLua.files() end, desc = 'Open File' },
      { '<c-s-p>', function() FzfLua.commands() end, desc = 'Open Commands' },
      { '<leader>f', function() FzfLua.blines() end, desc = 'Search Buffer' },
      { '<leader><leader>', function() FzfLua.live_grep_native() end, desc = 'Search Everywhere' },
      { '<leader><Tab>', function() FzfLua.oldfiles() end, desc = 'Recent Files' },
      { '<leader>m', function() FzfLua.marks() end, desc = '[M]arks' },
      { '<leader>sh', function() FzfLua.helptags() end, desc = '[S]earch [H]elp' },
      { '<leader>sk', function() FzfLua.keymaps() end, desc = '[S]earch keymaps?' },
      { '<leader>sm', function() FzfLua.manpages() end, desc = '[S]earch [M]an pages' },
      { '<leader>sw', function() FzfLua.grep_cword() end, desc = '[S]earch [w]ord' },
      { '<leader>z', function() FzfLua.zoxide() end, desc = '[Z]oxide' },
      { '<leader>t', "<cmd>TodoFzfLua<CR>", desc = 'Search [T]ODO' },
      { '<leader>st', "<cmd>TodoFzfLua<CR>", desc = 'Search [T]ODO' },
    },
    opts = {
      -- see https://github.com/ibhagwan/fzf-lua?tab=readme-ov-file#customization
      defaults = {
        file_icons = false,
        winopts = {
          height = 0.95,
          width = 0.93,
          border = 'double',
          preview = { title_pos = 'left' },
        },
      },
      -- VSCode-like file name first
      files = {
        formatter = 'path.filename_first',
        winopts = {
        },
      },
      blines = { previewer = false, winopts = { row = 0.4, height = 0.9, width = 0.8 } },
      oldfiles = {
        formatter = 'path.filename_first',
        include_current_session = true
      },
      code_actions = {
        -- requires git-delta
        previewer = "codeaction_native",
      },
      lsp = {
        -- see https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#symbolKind
        symbols = {
          symbol_style = 2,
          symbol_fmt = function(s) return s  end,
        }
      },
    },
  },
  {
    'smoka7/hop.nvim',
    version = "*",
    opts = {
        keys = 'asdfqwertyghjkluiopvbnm'
    },
    keys = {
        {'<leader>h', '<cmd>HopAnywhere<cr>', desc = '[H]op'}

    },
  },
  {
    'mikavilpas/yazi.nvim',
    event = 'VeryLazy',
    keys = {
      -- <C-s> greps inside the directory!
      { '<leader>-', '<cmd>Yazi<cr>', desc = 'Open yazi at the current file' },
      { '<leader>cw', '<cmd>Yazi cwd<cr>', desc = "Open the file manager in nvim's working directory" },
    },
    opts = {
      -- instead of netrw
      -- open_for_directories = true,
      keymaps = {
        show_help = '±', -- TODO: this
        open_file_in_horizontal_split = '<c-s>',
      },
      integrations = {
        grep_in_directory = 'fzf-lua'
      },
      yazi_floating_window_winblend = 0,
    },
  },
  {
    "saghen/blink.cmp",
    dependencies = 'rafamadriz/friendly-snippets',
    version = '*',
    opts = {
      keymap = {
          preset = 'super-tab',
          ['<CR>'] = {'accept', 'fallback'}
      },
      completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 500 },
        ghost_text = { enabled = true },
      },
      sources = {
        default = { 'snippets', 'lsp', 'path', 'buffer' },
        min_keyword_length = function(ctx)
          -- don't complete commands < 3 chars long
          if ctx.mode == 'cmdline' and string.find(ctx.line, ' ') == nil then return 2 end
          return 0
        end,
      },
      signature = {enabled = true}
    },
    opts_extend = { "sources.default" }
  },
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
    keys = {
        vim.keymap.set("n", "]t", function() require("todo-comments").jump_next() end, { desc = "Next todo comment" }),
        vim.keymap.set("n", "[t", function() require("todo-comments").jump_prev() end, { desc = "Previous todo comment" })
    }
  },
  {
    'kawre/leetcode.nvim',
    cmd = 'Leet',
    build = 'TSUpdate html',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'ibhagwan/fzf-lua', 'nvim-lua/plenary.nvim', 'MunifTanjim/nui.nvim', },
    opts = { lang = 'java' },
  },
  {
    "OXY2DEV/markview.nvim",
    lazy = false
  },
}
