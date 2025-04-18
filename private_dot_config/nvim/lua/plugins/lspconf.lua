return {
  {
    -- configures Lua LSP for Neovim config
    "folke/lazydev.nvim",
    ft = "lua",
    ---@module 'lazydev'
    ---@type lazydev.Config
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
      "mfussenegger/nvim-jdtls", -- NOTE: This is for Java specifically
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "saghen/blink.cmp",
    },
    ---@module 'lspconfig'
    ---@type lspconfig.Config
    opts = { servers = require("lsp").servers },
    config = function(_, opts)
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
        callback = function(event)
          -- local fzflua = require("fzf-lua")
          -- require("keymaps").ext_lsp(event, fzflua)
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

      local blink = require("blink.cmp")
      local lspconfig = require("lspconfig")

      -- This is just for Apple Xcode stuff, kinda ugly might remove
      -- lspconfig["sourcekit"].setup({
      --   capabilities = blink.get_lsp_capabilities(),
      --   cmd = vim.trim(vim.fn.system("xcrun -f sourcekit-lsp")),
      -- })

      for server, config in pairs(opts.servers) do
        config.capabilities = blink.get_lsp_capabilities(config.capabilities)
        lspconfig[server].setup(config)
      end
    end,
  },
  {
    -- Can do :set filetype=json to set stuff manually (just a reminder)
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    main = "nvim-treesitter.configs",
    -- dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
    ---@module 'nvim-treesitter'
    ---@type TSConfig
    opts = M.treesitter,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "VeryLazy",
    ---@module 'nvim-treesitter-context'
    ---@type TSContext.Config
    opts = {},
  },
}
