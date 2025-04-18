M = {}

M.servers = {
  clangd = {},
  rust_analyzer = {},
  basedpyright = {},
  bashls = {},
  lemminx = {},
  ts_ls = {},
  lua_ls = {},
}

-- https://github.com/stevearc/conform.nvim?tab=readme-ov-file#formatters
M.formatters_by_ft = {
  lua = { "stylua" },
  fish = { "fish_indent" },
  sh = { "shfmt" },
  rust = { "rustfmt", lsp_format = "fallback" },
  xml = { "lemminx" },
}

M.formatters = {}

---@type TSConfig
M.treesitter = {
  ensure_installed = {
    "bash",
    "c",
    "diff",
    "html",
    "lua",
    "luadoc",
    "python",
    "rust",
    "query",
    "vim",
    "vimdoc",
  },
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

return M
