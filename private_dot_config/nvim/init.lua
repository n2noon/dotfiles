--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- [[OPTIONS]]
-- See `:help vim.opt`
-- For more options, you can see `:help option-list`
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.mouse = 'a'       -- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.showmode = false  -- Don't show the mode, since it's already in the status line
vim.opt.breakindent = true
vim.opt.undofile = true   -- Save undo history

vim.opt.ignorecase = true -- Case-insensitive searching UNLESS \C or one or more capital letters in search term
vim.opt.smartcase = true

vim.opt.signcolumn = 'yes:1' -- Keep signcolumn on by default
-- vim.opt.updatetime = 250   -- Decrease update time
vim.opt.timeoutlen = 300   -- Displays which-key popup sooner

vim.opt.splitright = true  -- Configure how new splits should be opened
vim.opt.splitbelow = true

vim.opt.list = true -- Sets how neovim will display certain whitespace characters
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.opt.inccommand = 'split' -- Preview substitutions live
vim.opt.cursorline = true    -- Show which line cursor is on
vim.opt.scrolloff = 5       -- Minimal number of screen lines to keep above and below the cursor.

vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.conceallevel = 1 -- For obsidian.nvim mainly

vim.schedule(function()      -- This is delayed so startup time is quicker
  vim.opt.clipboard = 'unnamedplus'
end)

-- [[BASIC KEYMAPS]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode (and also dismiss lsp.buf.hover - this is hacky there's probably a better way to do it)
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>hl')
-- always center search results
vim.keymap.set('n', 'n', 'nzz', { silent = true })
vim.keymap.set('n', 'N', 'Nzz', { silent = true })
vim.keymap.set('n', '*', '*zz', { silent = true })
vim.keymap.set('n', '#', '#zz', { silent = true })
vim.keymap.set('n', 'g*', 'g*zz', { silent = true })

vim.keymap.set('n', 'H', '^')
vim.keymap.set('n', 'L', '$')

vim.keymap.set('n', ';', ':')

-- Some emacs lol
vim.keymap.set('n', '<C-a>', '^')
vim.keymap.set('n', '<C-e>', '$')

-- make j and k move by visual line, not actual line, when text is soft-wrapped
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')

-- Quitting, saving
vim.keymap.set('n', '<leader>wq', '<cmd>q<CR>', { desc = 'Quit' })
-- vim.keymap.set('n', '<leader>q', '<cmd>q<CR>', { desc = 'Quit' })
vim.keymap.set('n', '<leader>wv', ':vsplit<CR>', { desc = 'Vsplit' })
vim.keymap.set('n', '<leader>wh', ':split<CR>', { desc = 'Split' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Focus left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Focus right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Focus lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Focus upper window' })

-- [[ Basic Autocommands ]]
-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
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
    if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
    -- except for in git commit messages
    -- https://stackoverflow.com/questions/31449496/vim-ignore-specifc-file-in-autocommand
      if not vim.fn.expand('%:p'):find('.git', 1, true) then
        vim.cmd('exe "normal! g\'\\""')
      end
    end
  end
})

-- shorter columns in text because it reads better that way
local text = vim.api.nvim_create_augroup('text', { clear = true })
for _, pat in ipairs({'text', 'markdown', 'mail', 'gitcommit'}) do
  vim.api.nvim_create_autocmd('Filetype', {
    pattern = pat,
    group = text,
    command = 'setlocal spell tw=72 colorcolumn=73',
})
end

----- Plugins -----
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- Theme
  {
    -- "catppuccin/nvim",
    -- "loctvl842/monokai-pro.nvim",
    "folke/tokyonight.nvim",
    -- "rose-pine/neovim",
    lazy = false,
    priority = 1000,
    config = function()
      local scheme =
          -- "catppuccin-mocha"
          -- "monokai-pro"
          -- "rose-pine"
          -- "tokyonight-moon"
          "tokyonight-storm"
      vim.cmd.colorscheme(scheme)
    end
  },
  {
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    opts = {
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,
        -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
        -- default whick-key.nvim defined Nerd Font icons, otherwise define a string table
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },
      -- Document existing key chains
      spec = {
        { '<leader>s', group = '[S]earch' },
      },
    },
  },
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
        {"<c-p>", "<cmd>FzfLua files<cr>", desc = "Open File"},
        {"<c-s-p>", "<cmd>FzfLua commands<cr>", desc = "Open Commands"},
        {"<leader><leader>", "<cmd>FzfLua files<cr>", desc = 'Open File'},
        {"<leader>f", "<cmd>FzfLua blines<cr>", desc = 'Search Buffer'},
        {"<leader>F", "<cmd>FzfLua live_grep<cr>", desc = 'Search Everywhere'},
        {"<leader><Tab>", "<cmd>FzfLua oldfiles<cr>", desc = 'Recent Files'},
        {"<leader>sh", "<cmd>FzfLua helptags<cr>", desc = '[S]earch [H]elp'},
    },
    opts = {
        defaults = {
          file_icons = false,
          winopts = {
            height = 0.95, width = 0.93,
            border = "double",
            preview = { title_pos = 'left' },
          }
        },
        -- VSCode-like file name first
        files = { formatter = "path.filename_first" },
        blines = { previewer = false, winopts = { row = 0.4, height = 0.8, width = 0.7 } },
        oldfiles = { formatter = "path.filename_first" },
    }
  },
  -- TODO: configure this a bit more
  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    keys = {
      {"<leader>-", "<cmd>Yazi<cr>", desc = "Open yazi at the current file"},
      {"<leader>cw", "<cmd>Yazi cwd<cr>", desc = "Open the file manager in nvim's working directory"},
    },
    opts = {
      -- if you want to open yazi instead of netrw, see below for more info
      open_for_directories = true,
      keymaps = {
        show_help = '±', -- TODO: this
        open_file_in_horizontal_split = '<c-s>',
      },
      yazi_floating_window_winblend = 0,
    },
  },
  -- {
  --   "Exafunction/codeium.nvim",
  --   dependencies = {
  --       "nvim-lua/plenary.nvim",
  --       "hrsh7th/nvim-cmp",
  --   },
  --   opts = {}
  -- },
  -- LSP Plugins
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },
  -- TODO: this shouldnt be here and also idk if its even worth
  -- {
  --   'anuvyklack/help-vsplit.nvim',
  --   opts = {always = true}
  -- },
  { 'Bilal2453/luvit-meta', lazy = true },
  {
    -- LSP
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim',       opts = {} },

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

          map('gr', require('fzf-lua').lsp_references, '[G]oto [R]eferences')
          map('gi', require('fzf-lua').lsp_implementations, '[G]oto [I]mplementation')
          map('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
          map('gh', vim.lsp.buf.hover, 'Show hover')

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('<leader>d', require('fzf-lua').lsp_typedefs, 'Type [D]efinition')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          -- map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

          -- Fuzzy find all the symbols in your current workspace.
          --  Similar to document symbols, except searches over your entire project.
          -- map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map('<leader>n', vim.lsp.buf.rename, 'Re[n]ame')
          map('<leader>2', vim.lsp.buf.rename, 'Re[n]ame')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
          map('<C-.>', vim.lsp.buf.code_action, 'Code Action', { 'n', 'x' })

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map('gD', require('fzf-lua').lsp_declarations, '[G]oto [D]eclaration')

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
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

          -- The following code creates a keymap to toggle inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          -- if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
          --   map('<leader>th', function()
          --     vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
          --   end, '[T]oggle Inlay [H]ints')
          -- end
        end,
      })

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {
        clangd = {},
        rust_analyzer = {},
        basedpyright = {},
        bashls = {},
        ts_ls = {},
        --
        lua_ls = {
          settings = {
            Lua = {
              -- completion = {
              --   callSnippet = 'Replace',
              -- },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      }
      -- Ensure the servers and tools above are installed
      require('mason').setup()

      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format Lua code
      })

      require('mason-tool-installer').setup { ensure_installed = ensure_installed }
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
          -- Select the [n]ext item
          ['<C-n>'] = cmp.mapping.select_next_item(),
          -- Select the [p]revious item
          ['<C-p>'] = cmp.mapping.select_prev_item(),

          -- Scroll the documentation window [b]ack / [f]orward
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),

          -- Accept ([y]es) the completion.
          --  This will auto-import if your LSP supports it.
          --  This will expand snippets if the LSP sent a snippet.
          ['<C-y>'] = cmp.mapping.confirm { select = true },

          -- If you prefer more traditional completion keymaps,
          -- you can uncomment the following lines
          ['<CR>'] = cmp.mapping.confirm { select = true },
          ['<Tab>'] = cmp.mapping.select_next_item(),
          ['<S-Tab>'] = cmp.mapping.select_prev_item(),

          -- Manually trigger a completion from nvim-cmp.
          --  Generally you don't need this, because nvim-cmp will display
          --  completions whenever it has completion options available.
          ['<C-Space>'] = cmp.mapping.complete {},

          -- Think of <c-l> as moving to the right of your snippet expansion.
          --  So if you have a snippet that's like:
          --  function $name($args)
          --    $body
          --  end
          --
          -- <c-l> will move you to the right of each of the expansion locations.
          -- <c-h> is similar, except moving you backwards.
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
  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false }
  },
  {
  'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true
  },
  -- Highlight, edit, and navigate code
  {
    -- Can do :set filetype=json to set stuff manually (just a reminder)
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    opts = {
      ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'query', 'vim', 'vimdoc' },
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
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "VeryLazy",
    opts = {}
  },
 -- Misc
  -- {
  --   "3rd/image.nvim",
  --   event = "VeryLazy",
  --   build = false,
  --   opts = {
  --
  --   }
  -- },
  {
    "kawre/leetcode.nvim",
    event = "VeryLazy",
    build = "TSUpdate html", -- if you have `nvim-treesitter` installed
    dependencies = {
        -- "nvim-telescope/telescope.nvim",
        "ibhagwan/fzf-lua",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        -- "3rd/image.nvim"
    },
    opts = {
      ---@type lc.lang
      lang = "java",
      -- -@type boolean
      -- image_support = true
    },
  },
  -- {
  --   "epwalsh/obsidian.nvim",
  --   -- https://github.com/epwalsh/obsidian.nvim
  --   version = "*",  -- recommended, use latest release instead of latest commit
  --   lazy = true,
  --   event = {
  --     -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --     -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --     -- refer to `:h file-pattern` for more examples
  --     "BufReadPre /Users/kalk/Notes/*.md",
  --     "BufNewFile /Users/kalk/Notes/notes/*.md",
  --   },
  --   dependencies = {
  --     -- Required.
  --     "nvim-lua/plenary.nvim",
  --   },
  --   opts = {
  --     workspaces = {
  --       {
  --         name = "personal",
  --         path = "~/Notes",
  --       },
  --     },
  --   }
  -- },
},

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
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
