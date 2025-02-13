--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
--  Most of this config shamelessly borrowed from kickstart.nvim
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- TODO:
-- - get task running/debugging
-- - get bookmarks set up
-- - get quickfix set up
-- - refactor this into keybinds and lsp
-- - use mini.ai for ciq?
-- - surround
--
--
-- You can use \zs and \ze to mark the start and end of the capture, anything on the other side of these will be matched against but not captured.
-- For example, this will change words beginning with foo to foobar:
-- s/foo\zs\w\+/bar/

-- [[OPTIONS]]
-- See `:help vim.o`
-- For more options, you can see `:help option-list`
vim.o.title = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.mouse = 'a' -- Enable mouse mode, can be useful for resizing splits for example!
vim.o.showmode = false -- Don't show the mode, since it's already in the status line
vim.o.breakindent = true
vim.o.undofile = true -- Save undo history
vim.o.laststatus = 1

vim.o.ignorecase = true -- Case-insensitive searching UNLESS \C or one or more capital letters in search term
vim.o.smartcase = true

vim.o.signcolumn = 'yes:1' -- Keep signcolumn on by default
-- vim.o.updatetime = 250   -- Decrease update time
vim.o.timeoutlen = 300 -- Displays which-key popup sooner

vim.o.splitbelow = true
vim.o.splitright = true -- Configure how new splits should be opened

vim.o.list = true -- Sets how neovim will display certain whitespace characters
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.o.inccommand = 'split' -- Preview substitutions live
vim.o.cursorline = true -- Show which line cursor is on
vim.o.scrolloff = 5 -- Minimal number of screen lines to keep above and below the cursor.

vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

vim.o.conceallevel = 1 -- For obsidian.nvim mainly

vim.schedule(function() -- This is delayed so startup time is quicker
  vim.o.clipboard = 'unnamedplus'
end)

-- [[BASIC KEYMAPS]]

-- Clear highlights on search when pressing <Esc> in normal mode (and also dismiss lsp.buf.hover - this is hacky there's probably a better way to do it)
vim.keymap.set({ 'n', 'v' }, '<C-/>', ':norm gcc<CR>')
-- vim.keymap.set({'n', 'v'}, '<leader>c', ":norm gcc<CR>")
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>hl')
-- always center search results
vim.keymap.set('n', 'n', 'nzz', { silent = true })
vim.keymap.set('n', 'N', 'Nzz', { silent = true })
vim.keymap.set('n', '*', '*zz', { silent = true })
vim.keymap.set('n', '#', '#zz', { silent = true })
vim.keymap.set('n', 'g*', 'g*zz', { silent = true })

vim.keymap.set('n', 'H', '_')
vim.keymap.set('n', 'L', '$')
vim.keymap.set('n', ';', ':')

-- This is different to ciw, you can substitute next word too with n
vim.keymap.set('n', '-', '*Ncgn', { silent = true, desc = 'Substitute word under cursor' })
-- Normal mode Backspace alternates buffers
vim.keymap.set('n', '<Tab>', ':b#<CR>', { silent = true })
vim.keymap.set('n', '<Backspace>', ':b#<CR>', { silent = true })

-- make j and k move by visual line, not actual line, when text is soft-wrapped
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')

-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- LEADER BINDS --
-- q -
-- w - window operations
-- e - navigation
-- r - task runner
-- t -
-- y -
-- u -
-- i -
-- o - symbols
-- p -
-- r -
-- r -
-- r -
-- r -

-- Quitting, saving
vim.keymap.set('n', '<leader>wq', '<cmd>q<CR>', { desc = 'Quit' })
-- vim.keymap.set('n', '<leader>q', '<cmd>q<CR>', { desc = 'Quit' })
vim.keymap.set('n', '<leader>wv', ':vsplit<CR>', { desc = 'Vsplit' })
vim.keymap.set('n', '<leader>wh', ':split<CR>', { desc = 'Split' })

-- More accessible %
vim.keymap.set('n', '<leader>e', '%')

-- Exit terminal mode with double Esc
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Focus left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Focus right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Focus lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Focus upper window' })

vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Focus upper window' })

-- Autocommands
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- jump to last edit position on opening file
vim.api.nvim_create_autocmd('BufReadPost', {
  pattern = '*',
  callback = function()
    if vim.fn.line '\'"' > 1 and vim.fn.line '\'"' <= vim.fn.line '$' then
      -- except for in git commit messages
      -- https://stackoverflow.com/questions/31449496/vim-ignore-specifc-file-in-autocommand
      if not vim.fn.expand('%:p'):find('.git', 1, true) then
        vim.cmd 'exe "normal! g\'\\""'
      end
    end
  end,
})

-- open man/help pages in right split
vim.api.nvim_create_autocmd('BufEnter', {
  callback = function(opts)
    if vim.bo[opts.buf].filetype == 'help' or vim.bo[opts.buf].filetype == 'man' then
      vim.cmd 'wincmd L'
    end
  end,
})

----- Plugins -----
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
---@diagnostic disable-next-line: undefined-field
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup(
  {
    -- Theme
    {
      -- "catppuccin/nvim",
      -- "loctvl842/monokai-pro.nvim",
      -- "folke/tokyonight.nvim",
      'ellisonleao/gruvbox.nvim',
      -- "rose-pine/neovim",
      lazy = false,
      priority = 1000,
      config = function()
        local scheme =
          -- "catppuccin-mocha"
          -- "monokai-pro"
          -- "tokyonight-moon"
          -- "tokyonight-storm"
          'gruvbox'
        -- "rose-pine"
        vim.cmd.colorscheme(scheme)
      end,
    },
    {
      'folke/snacks.nvim',
      -- see https://github.com/folke/snacks.nvim?tab=readme-ov-file#-usage
      priority = 1000,
      lazy = false,
      opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        bigfile = { enabled = true },
        dashboard = { enabled = true },
        debug = { enabled = true },
        lazygit = { enabled = true },
        -- explorer = { enabled = true },
        -- indent = { enabled = true },
        -- input = { enabled = true },
        -- picker = { enabled = true },
        -- notifier = { enabled = true },
        quickfile = { enabled = true },
        rename = { enabled = true },
        scope = { enabled = true },
        scratch = { enabled = true },
        -- scroll = { enabled = true },
        statuscolumn = { enabled = true },
        terminal = { enabled = true },
        toggle = { enabled = true },
        -- words = { enabled = true },
      },
      keys = {
        { '<leader>g', function() Snacks.lazygit() end, desc = 'Lazygit', },
        { '<leader>..', function() Snacks.scratch() end, desc = 'Toggle Scratch Buffer', },
        { '<leader>.,', function() Snacks.scratch.select() end, desc = 'Select Scratch Buffer', },
        { '<leader>N', function() Snacks.rename.rename_file() end, desc = 'Rename File', },
        { "<c-'>", function() Snacks.terminal() end, desc = 'Toggle Terminal', },
        { '<leader>t', function() Snacks.terminal() end, desc = 'Toggle Terminal', },
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
    -- LSP Plugins
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

        -- Allows extra capabilities provided by nvim-cmp
        'hrsh7th/cmp-nvim-lsp',
      },
      config = function()
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

        -- Extend Neovim LSP capabilities
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

        -- Enable these language servers
        -- Add any additional override configuration in the following tables. Available keys are:
        -- - cmd (table): Override the default command used to start the server
        -- - filetypes (table): Override the default list of associated filetypes for the server
        -- - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
        -- - settings (table): Override the default settings passed when initializing the server.
        -- For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
        local servers = {
          clangd = {},
          rust_analyzer = {},
          basedpyright = {},
          bashls = {},
          ts_ls = {},
          lua_ls = {},
        }
        -- Ensure the servers and tools above are installed
        require('mason').setup()

        local ensure_installed = vim.tbl_keys(servers or {})
        vim.list_extend(ensure_installed, {
          'stylua',
        })

        require('mason-tool-installer').setup { ensure_installed = ensure_installed }
        ---@diagnostic disable-next-line: missing-fields
        require('mason-lspconfig').setup {
          handlers = {
            function(server_name)
              local server = servers[server_name] or {}
              -- This handles overriding only values explicitly passed
              -- by the server configuration above. Useful when disabling
              -- certain features of an LSP (for example, turning off formatting for ts_ls)
              server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
              require('lspconfig')[server_name].setup(server)
            end,
          },
        }
      end,
    },
    { -- Autocompletion
      'hrsh7th/nvim-cmp',
      event = 'InsertEnter',
      dependencies = {
        -- Snippet Engine & its associated nvim-cmp source
        {
          'L3MON4D3/LuaSnip',
          build = (function()
            -- Build Step is needed for regex support in snippets.
            -- This step is not supported in many windows environments.
            -- Remove the below condition to re-enable on windows.
            if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
              return
            end
            return 'make install_jsregexp'
          end)(),
          dependencies = {
            -- `friendly-snippets` contains a variety of premade snippets.
            --    See the README about individual language/framework/plugin snippets:
            --    https://github.com/rafamadriz/friendly-snippets
            {
              'rafamadriz/friendly-snippets',
              config = function()
                require('luasnip.loaders.from_vscode').lazy_load()
              end,
            },
          },
        },
        'saadparwaiz1/cmp_luasnip',

        -- Adds other completion capabilities.
        --  nvim-cmp does not ship with all sources by default. They are split
        --  into multiple repos for maintenance purposes.
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-path',
      },
      config = function()
        -- See `:help cmp`
        local cmp = require 'cmp'
        local luasnip = require 'luasnip'
        luasnip.config.setup {}

        cmp.setup {
          snippet = {
            expand = function(args)
              luasnip.lsp_expand(args.body)
            end,
          },
          completion = { completeopt = 'menu,menuone,noinsert' },

          -- For an understanding of why these mappings were
          -- chosen, you will need to read `:help ins-completion`
          --
          -- No, but seriously. Please read `:help ins-completion`, it is really good!
          mapping = cmp.mapping.preset.insert {
            ['<C-n>'] = cmp.mapping.select_next_item(),
            ['<C-p>'] = cmp.mapping.select_prev_item(),
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-y>'] = cmp.mapping.confirm { select = true },
            ['<CR>'] = cmp.mapping.confirm { select = true },
            ['<Tab>'] = cmp.mapping.select_next_item(),
            ['<S-Tab>'] = cmp.mapping.select_prev_item(),
            -- Manually trigger a completion from nvim-cmp.
            ['<C-Space>'] = cmp.mapping.complete {},

            ['<C-l>'] = cmp.mapping(function()
              if luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
              end
            end, { 'i', 's' }),
            ['<C-h>'] = cmp.mapping(function()
              if luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
              end
            end, { 'i', 's' }),

            -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
            --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
          },
          sources = {
            {
              name = 'lazydev',
              -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
              group_index = 0,
            },
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
            { name = 'codeium' },
            { name = 'path' },
          },
        }
      end,
    },
    {
      'folke/todo-comments.nvim',
      event = 'VimEnter',
      dependencies = { 'nvim-lua/plenary.nvim' },
      opts = { signs = false },
    },
    {
      'stevearc/conform.nvim',
      -- Look at this https://github.com/stevearc/conform.nvim/issues/192
      dependencies = { 'mason.nvim' },
      -- lazy = true,
      -- cmd = 'ConformInfo',
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
      main = 'nvim-treesitter.configs', -- Sets main module to use for opts
      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
      opts = {
        ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'python', 'rust', 'query', 'vim', 'vimdoc' },
        -- Autoinstall languages that are not installed
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
      build = 'TSUpdate html', -- if you have `nvim-treesitter` installed
      dependencies = {
        -- "nvim-telescope/telescope.nvim",
        'ibhagwan/fzf-lua',
        'nvim-lua/plenary.nvim',
        'MunifTanjim/nui.nvim',
      },
      opts = {
        lang = 'java',
      },
    },
    -- DEBUGGING --
    -- https://www.lazyvim.org/extras/dap/core
    -- shamelessly borrowed from https://github.com/tjdevries/config.nvim/blob/master/lua/custom/plugins/dap.lua
    {
      'mfussenegger/nvim-dap',
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

        -- Handled by nvim-dap-go
        -- dap.adapters.go = {
        --   type = "server",
        --   port = "${port}",
        --   executable = {
        --     command = "dlv",
        --     args = { "dap", "-l", "127.0.0.1:${port}" },
        --   },
        -- }

        -- local elixir_ls_debugger = vim.fn.exepath "elixir-ls-debugger"
        -- if elixir_ls_debugger ~= "" then
        -- dap.adapters.mix_task = {
        -- type = "executable",
        -- command = elixir_ls_debugger,
        -- }

        -- dap.configurations.elixir = {
        -- {
        -- type = "mix_task",
        -- name = "phoenix server",
        -- task = "phx.server",
        -- request = "launch",
        -- projectDir = "${workspaceFolder}",
        -- exitAfterTaskReturns = false,
        -- debugAutoInterpretAllModules = false,
        -- },
        -- }
        -- end

        vim.keymap.set('n', '<leader>da', dap.toggle_breakpoint)
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

        dap.listeners.before.attach.dapui_config = function() ui.open() end
        dap.listeners.before.launch.dapui_config = function() ui.open() end
        dap.listeners.before.event_terminated.dapui_config = function() ui.close() end
        dap.listeners.before.event_exited.dapui_config = function() ui.close() end
      end,
    },
  },
  ---@diagnostic disable-next-line: missing-fields
  {
    ui = {
      -- If you are using a Nerd Font: set icons to an empty table which will use the
      -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
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
