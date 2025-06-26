-- vim.o.background = "light"
vim.o.background = "dark"

-- local grey = "#928374"
-- vim.api.nvim_set_hl(0, "SnacksDashboardDir", { fg = grey })

return {
  {
    "catppuccin/nvim",
    -- "loctvl842/monokai-pro.nvim",
    -- "folke/tokyonight.nvim",
    -- "ellisonleao/gruvbox.nvim",
    -- "neanias/everforest-nvim",
    --   -- "rose-pine/neovim",
--    ---@module "gruvbox"
--    ---@type GruvboxConfig
    config = function()
      local scheme =
        -- "everforest"
        -- "gruvbox"
      -- require("everforest").setup({
      --   background = "hard",
      --   ui_contrast = "high"
      -- })
      "catppuccin-mocha"
      -- "monokai-pro"
      -- "tokyonight-moon"
      -- "tokyonight-storm"
      -- "rose-pine"
      -- require("gruvbox").setup({
      --   palette_overrides = {
      --     bright_red = "#e35a29",
      --     bright_green = "#aeb541",
      --     bright_yellow = "#ffc020",
      --   },
      --   overrides = {
      --     ["@markup.heading.1.markdown"] = { fg = "#e35a29", bg = "", bold = true },
      --     ["@markup.heading.2.markdown"] = { fg = "#fe8019", bg = "", bold = true },
      --     ["@markup.heading.3.markdown"] = { fg = "#ffc020", bg = "", bold = true },
      --     ["@markup.heading.4.markdown"] = { fg = "#aeb541", bg = "", bold = true },
      --     ["@markup.heading.5.markdown"] = { fg = "#83a598", bg = "", bold = true },
      --     ["@markup.heading.6.markdown"] = { fg = "#d3869b", bg = "", bold = true },
      --   },
      -- })
      vim.cmd.colorscheme(scheme)
    end,
    lazy = false,
    priority = 1000,
  },
}
