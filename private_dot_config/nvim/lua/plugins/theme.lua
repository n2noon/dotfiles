-- vim.o.background = "light"
vim.o.background = "dark"

return {
  {
    -- "catppuccin/nvim",
    -- "loctvl842/monokai-pro.nvim",
    -- "folke/tokyonight.nvim",
    "ellisonleao/gruvbox.nvim",
    -- "neanias/everforest-nvim",
    --   -- "rose-pine/neovim",
    ---@module "gruvbox"
    ---@type GruvboxConfig
    config = function()
      local scheme =
        -- "everforest"
        "gruvbox"
      -- require("everforest").setup({
      --   background = "hard",
      --   ui_contrast = "high"
      -- })
      -- "catppuccin-mocha"
      -- "monokai-pro"
      -- "tokyonight-moon"
      -- "tokyonight-storm"
      -- "rose-pine"
      require("gruvbox").setup({
        palette_overrides = {
          bright_red = "#e35a29",
          bright_green = "#aeb541",
          bright_yellow = "#ffc020",
        },
      })
      vim.cmd.colorscheme(scheme)
    end,
    lazy = false,
    priority = 1000,
  },
}
