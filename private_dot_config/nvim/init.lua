--  NOTE: options come before plugins (keep leader key binding)
require 'options'
require 'keymaps'
require 'autocmds'

----- PLUGINS -----
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  --- THEME ---
  {
    -- "catppuccin/nvim",
    -- "loctvl842/monokai-pro.nvim",
    -- "folke/tokyonight.nvim",
    'ellisonleao/gruvbox.nvim',
    -- "rose-pine/neovim",
    config = function() local scheme =
        -- "catppuccin-mocha"
        -- "monokai-pro"
        -- "tokyonight-moon"
        -- "tokyonight-storm"
        'gruvbox'
      -- "rose-pine"
      vim.cmd.colorscheme(scheme)
    end,
    lazy = false,
    priority = 1000,
  },
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
    -- opts = {
    -- },
  },
  {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = {
      { '<c-p>', function() FzfLua.files() end, desc = 'Open File', },
      { '<c-s-p>', function() FzfLua.commands() end, desc = 'Open Commands', },
      { '<leader>f', function() FzfLua.blines() end, desc = 'Search Buffer', },
      { '<leader><leader>', function() FzfLua.live_grep() end, desc = 'Search Everywhere', },
      { '<leader><Tab>', function() FzfLua.oldfiles() end, desc = 'Recent Files', },
      { '<leader>sh', function() FzfLua.helptags() end, desc = '[S]earch [H]elp', },
      { '<leader>sk', function() FzfLua.keymaps() end, desc = '[S]earch keymaps?', },
      { '<leader>sm', function() FzfLua.manpages() end, desc = '[S]earch [M]an pages', },
      { '<leader>sw', function() FzfLua.grep_cword() end, desc = '[S]earch [w]ord', },
      { '<leader>z', function() FzfLua.zoxide() end, desc = '[Z]oxide', },
      { '<leader>t', "<cmd>TodoFzfLua<CR>", desc = 'Search [T]ODO', },
      { '<leader>st', "<cmd>TodoFzfLua<CR>", desc = 'Search [T]ODO', },
      -- {"<leader>o", function() FzfLua.treesitter() end, desc = 'Treesitter symbols'},
    },
    opts = {
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
      files = { formatter = 'path.filename_first' },
      blines = { previewer = false, winopts = { row = 0.4, height = 0.8, width = 0.7 } },
      oldfiles = { formatter = 'path.filename_first' },
    },
  },
  -- TODO: configure this a bit more
  {
    'mikavilpas/yazi.nvim',
    event = 'VeryLazy',
    keys = {
      { '<leader>-', '<cmd>Yazi<cr>', desc = 'Open yazi at the current file' },
      { '<leader>cw', '<cmd>Yazi cwd<cr>', desc = "Open the file manager in nvim's working directory" },
    },
    opts = {
      -- instead of netrw
      open_for_directories = true,
      keymaps = {
        show_help = '±', -- TODO: this
        open_file_in_horizontal_split = '<c-s>',
      },
      yazi_floating_window_winblend = 0,
    },
  },
  --- LSP ---
  {
    -- configures Lua LSP for Neovim config
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      { 'williamboman/mason.nvim', opts = {} }, -- NOTE: Must be loaded before dependants
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      'saghen/blink.cmp'
    },
    opts = {
      servers = {
        clangd = {},
        rust_analyzer = {},
        basedpyright = {},
        bashls = {},
        ts_ls = {},
        lua_ls = {},
      },
    },
    config = function(_, opts)
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          local FzfLua = require 'fzf-lua'
          map('gr', FzfLua.lsp_references, '[G]oto [R]eferences')
          map('gi', FzfLua.lsp_implementations, '[G]oto [I]mplementation')
          map('gd', FzfLua.lsp_definitions, '[G]oto [D]efinition')
          map('gh', vim.lsp.buf.hover, 'Show hover')
          map('gt', FzfLua.lsp_typedefs, '[G]oto [T]ype')

          map('<leader>n', vim.lsp.buf.rename, 'Re[n]ame')
          map('<leader>o', FzfLua.lsp_document_symbols, 'Symb[o]ls')
          map('<leader>q', FzfLua.lsp_document_diagnostics, 'Diagnosti[q]s')
          map('<leader>sq', FzfLua.lsp_document_diagnostics, '[S]earch Diagnosti[q]s')

          map('<C-.>', require('fzf-lua').lsp_code_actions, 'Code Action', { 'n', 'x' })

          map('gD', require('fzf-lua').lsp_declarations, '[G]oto [D]eclaration')

          -- Highlight under cursor
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- Inlay hints
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      require('mason').setup()

      local ensure_installed = vim.tbl_keys(opts.servers or {})
      vim.list_extend(ensure_installed, {
        'stylua',
      })

      require('mason-tool-installer').setup { ensure_installed = ensure_installed }
      require('mason-lspconfig').setup()
        -- {
        -- handlers = {
      local lspconfig = require('lspconfig')

      for server, config in pairs(opts.servers) do
        config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
        lspconfig[server].setup(config)
      end
    end,
  },
  {
    "saghen/blink.cmp",
    dependencies = 'rafamadriz/friendly-snippets',
    version = '*',
    opts = {
      keymap = { preset = 'super-tab' },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
        min_keyword_length = function(ctx)
          -- don't complete commands < 3 chars long
          if ctx.mode == 'cmdline' and string.find(ctx.line, ' ') == nil then return 2 end
          return 0
        end
      },
      -- documentation = { auto_show = true, auto_show_delay_ms = 500 },
    },
    opts_extend = { "sources.default" }
  },
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },
  {
    'stevearc/conform.nvim',
    -- see https://github.com/stevearc/conform.nvim/issues/192
    dependencies = { 'mason.nvim' },
    lazy = true,
    cmd = 'ConformInfo',
    keys = {
      {
        '<leader>cf',
        function()
          require('conform').format { formatters = { 'injected' }, timeout_ms = 3000 }
        end,
        mode = { 'n', 'v' },
        desc = 'Format Injected Langs',
      },
    },
    opts = {
      format_on_save = {
        -- I recommend these options. See :help conform.format for details.
        lsp_format = 'fallback',
        timeout_ms = 500,
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        fish = { 'fish_indent' },
        sh = { 'shfmt' },
        rust = { 'rustfmt', lsp_format = 'fallback' },
      },
    },
  },
  {
    -- Can do :set filetype=json to set stuff manually (just a reminder)
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
    opts = {
      ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'python', 'rust', 'query', 'vim', 'vimdoc' },
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
  },
  { 'nvim-treesitter/nvim-treesitter-context', event = 'VeryLazy', opts = {} },
  {
    'kawre/leetcode.nvim',
    cmd = 'Leet',
    build = 'TSUpdate html',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'ibhagwan/fzf-lua', 'nvim-lua/plenary.nvim', 'MunifTanjim/nui.nvim', },
    opts = { lang = 'java' },
  },
  -- DEBUGGING --
  -- taken from https://github.com/tjdevries/config.nvim/blob/master/lua/custom/plugins/dap.lua
  -- look at https://www.reddit.com/r/neovim/comments/1ho7n3v/what_do_you_miss_from_vscode_if_you_even_miss/m48olf9/
  {
    'mfussenegger/nvim-dap',
    event = "VeryLazy",
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'theHamsta/nvim-dap-virtual-text',
      'nvim-neotest/nvim-nio',
      'williamboman/mason.nvim',
    },
    config = function()
      local dap = require 'dap'
      local ui = require 'dapui'

      require('dapui').setup()

      vim.keymap.set('n', '<leader>da', dap.toggle_breakpoint, {desc = "Toggle breakpoint"})
      vim.keymap.set('n', '<leader>dl', dap.run_to_cursor)

      -- Eval var under cursor
      vim.keymap.set('n', '<space>?', function()
        require('dapui').eval(nil, { enter = true })
      end)

      vim.keymap.set('n', '<leader>dc', dap.continue)
      vim.keymap.set('n', '<leader>di', dap.step_into)
      vim.keymap.set('n', '<leader>dv', dap.step_over)
      vim.keymap.set('n', '<leader>do', dap.step_out)
      vim.keymap.set('n', '<leader>db', dap.step_back)
      vim.keymap.set('n', '<leader>dr', dap.restart)

      dap.adapters.lldb = {
        type = "executable",
        command = "/Users/kalk/.local/share/nvim/mason/packages/codelldb",
        name = "lldb",
      }

      dap.configurations.rust = {
        {
          name = "hello-dap",
          type = "lldb",
          request = "launch",
          program = function()
              return vim.fn.getcwd() .. "/target/debug/hello-dap"
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
      }

      dap.listeners.before.attach.dapui_config = function() ui.open() end
      dap.listeners.before.launch.dapui_config = function() ui.open() end
      dap.listeners.before.event_terminated.dapui_config = function() ui.close() end
      dap.listeners.before.event_exited.dapui_config = function() ui.close() end
    end,
  }},
  {
    ui = {
      -- If using a Nerd Font: set icons to an empty table which uses the
      -- default lazy.nvim defined Nerd Font icons, otherwise define unicode icons table
      icons = vim.g.have_nerd_font and {} or {
        cmd = '⌘',
        config = '🛠',
        event = '📅',
        ft = '📂',
        init = '⚙',
        keys = '🗝',
        plugin = '🔌',
        runtime = '💻',
        require = '🌙',
        source = '📄',
        start = '🚀',
        task = '📌',
        lazy = '💤 ',
      },
    },
  }
)

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
