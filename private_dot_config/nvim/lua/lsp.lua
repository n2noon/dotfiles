M = {}

M.servers = {
  clangd = {},
  -- Disable if using rustaceanvim
  rust_analyzer = {},
  basedpyright = {},
  bashls = {},
  -- For java
  -- jdtls = {},
  lemminx = {},
  -- nil_ls = {},
  ts_ls = {},
  lua_ls = {},
}

-- https://github.com/stevearc/conform.nvim?tab=readme-ov-file#formatters
-- TODO: maybe have some auto-install, mason-tool-installer does this
M.formatters_by_ft = {
  css = { "biome" },
  fish = { "fish_indent" },
  just = { "just" },
  json = { "biome" },
  lua = { "stylua" },
  nix = { "alejandra" },
  python = { "ruff_fix", "ruff_format" },
  rust = { "rustfmt", lsp_format = "fallback" },
  sh = { "shfmt" },
  xml = { "xmlformatter" },
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
