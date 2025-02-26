return {
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
          map('gD', FzfLua.lsp_declarations, '[G]oto [D]eclaration')
          map('gh', vim.lsp.buf.hover, 'Show hover')
          map('gt', FzfLua.lsp_typedefs, '[G]oto [T]ype')

          map('<C-.>', FzfLua.lsp_code_actions, 'Code Action', { 'n', 'x' })

          -- map('<leader>n', vim.lsp.buf.rename, 'Re[n]ame')
          map('<leader>o', FzfLua.lsp_document_symbols, 'Symb[o]ls')
          -- Diagnostics
          map('<leader>ql', FzfLua.lsp_document_diagnostics, 'Diagnosti[q]s [L]ist')
          map('<leader>qw', FzfLua.lsp_workspace_diagnostics, 'Diagnosti[q]s [W]orkspace')
          map('<leader>qn', vim.diagnostic.goto_next, 'Diagnosti[q]s [N]ext')
          map('<leader>qp', vim.diagnostic.goto_prev, 'Diagnosti[q]s [P]revious')

          -- Highlight under cursor
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          -- if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
          --   -- local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
          --   -- vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
          --   --   buffer = event.buf,
          --   --   group = highlight_augroup,
          --   --   callback = vim.lsp.buf.document_highlight,
          --   -- })
          --   --
          --   -- vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
          --   --   buffer = event.buf,
          --   --   group = highlight_augroup,
          --   --   callback = vim.lsp.buf.clear_references,
          --   -- })
          --
          --   vim.api.nvim_create_autocmd('LspDetach', {
          --     group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
          --     callback = function(event2)
          --       vim.lsp.buf.clear_references()
          --       vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
          --     end,
          --   })
          -- end

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
    -- dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
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
      -- textobjects = {
      --     select = {
      --         enable = true,
      --         keymaps = {
      --             ["af"] = { query = "@function.outer", desc = "a function" },
      --             ["if"] = { query = "@function.inner", desc = "inner function" },
      --             ["ac"] = { query = "@comment.outer", desc = "a comment" },
      --             ["ic"] = { query = "@comment.inner", desc = "inner comment" },
      --         },
      --     },
      --     swap = {
      --         enable = true,
      --         swap_next = {
      --             ["<LEADER>a"] = "@parameter.inner",
      --         },
      --         swap_previous = {
      --             ["<LEADER>A"] = "@parameter.inner",
      --         },
      --     },
      --     move = {
      --         enable = true,
      --         goto_next_start = {
      --             ["]f"] = "@function.outer",
      --         },
      --         goto_next_end = {
      --             ["]F"] = "@function.outer",
      --         },
      --         goto_previous_start = {
      --             ["[f"] = "@function.outer",
      --         },
      --         goto_previous_end = {
      --             ["[F"] = "@function.outer",
      --         },
      --     },
      -- },
    },
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    event = 'VeryLazy',
    opts = {}
  },
}
