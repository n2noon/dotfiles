vim.lsp.enable('nixd')
vim.lsp.enable('nil')
vim.lsp.enable('fish_lsp')

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
        { path = "${3rd}/luv/library", words = { "vim%.uv" } }
      }
    }
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    event = "VeryLazy",
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
        "saghen/blink.cmp",
    },
  },
  {
    -- Can do :set filetype=json to set stuff manually (just a reminder)
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    main = "nvim-treesitter.configs",
    -- dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
    ---@module 'nvim-treesitter'
    ---@type TSConfig
    opts = {
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { "ruby" },
      },
      indent = {
        enable = true,
        disable = { "ruby" },
      },
    }
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "VeryLazy",
    ---@module 'nvim-treesitter-context'
    ---@type TSContext.Config
    opts = {},
  },
}
