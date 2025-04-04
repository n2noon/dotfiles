-- vim.o.background = "light"
vim.o.background = "dark"

return {
  {
    -- "catppuccin/nvim",
    -- "loctvl842/monokai-pro.nvim",
    -- "folke/tokyonight.nvim",
    "ellisonleao/gruvbox.nvim",
    --   -- "rose-pine/neovim",
    config = function()
      local scheme =
        "gruvbox"
        -- require("gruvbox").setup({contrast = "soft"})
        -- "catppuccin-mocha"
        -- "monokai-pro"
        -- "tokyonight-moon"
        -- "tokyonight-storm"
      -- "rose-pine"
        vim.cmd.colorscheme(scheme)
    end,
    lazy = false,
    priority = 1000,
  },
}
