return {
  {
    -- configures Lua LSP for Neovim config
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      { "williamboman/mason.nvim", opts = {} }, -- NOTE: Must be loaded before dependants
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "saghen/blink.cmp",
    },
    opts = { servers = require("lsp").servers },
    config = function(_, opts)
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
        callback = function(event)
          local fzflua = require("fzf-lua")
          require("keymaps").ext_lsp(event, fzflua)
          require("keymaps").lsp(event)
          -- Highlight under cursor
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          vim.api.nvim_create_autocmd("LspDetach", {
            group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
            end,
          })
        end,
      })

      require("mason").setup()
      require("mason-tool-installer").setup({})
      require("mason-lspconfig").setup()

      local lspconfig = require("lspconfig")
      for server, config in pairs(opts.servers) do
        config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
        lspconfig[server].setup(config)
      end
    end,
  },
  {
    "stevearc/conform.nvim",
    -- see https://github.com/stevearc/conform.nvim/issues/192
    dependencies = { "mason.nvim" },
    -- lazy = true,
    cmd = "ConformInfo",
    keys = require("keymaps").conform,
    opts = {
      format_on_save = {
        -- I recommend these options. See :help conform.format for details.
        lsp_format = "fallback",
        timeout_ms = 500,
      },
      formatters_by_ft = require("lsp").formatters_by_ft,
      formatters = require("lsp").formatters,
    },
  },
  {
    -- Can do :set filetype=json to set stuff manually (just a reminder)
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    main = "nvim-treesitter.configs",
    -- dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
    opts = M.treesitter,
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
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "VeryLazy",
    opts = {},
  },
}
