return {
  {
    "lewis6991/gitsigns.nvim",
    enabled = false,
    ---@module 'gitsigns'
    ---@type Gitsigns.Config
    opts = {},
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "echasnovski/mini.pick", -- optional
    },
    cmd = {
      "Neogit",
      "NeogitCommit",
      "NeogitLogCurrent",
      "NeogitResetState",
    },
    opts = {},
    keys = {
      {
        "<leader>gg",
        "<cmd>Neogit<cr>",
        mode = { "n", "v" },
        desc = "Neogit",
      },
      {
        "<leader>gf",
        "<cmd>NeogitLogCurrent<cr>",
        mode = { "n", "v" },
        desc = "Neogit: Current file log",
      },
      {
        "<leader>gc",
        "<cmd>NeogitCommit<cr>",
        mode = { "n", "v" },
        desc = "Neogit: Commit",
      },
      {
        "<leader>gr",
        "<cmd>NeogitResetState<cr>",
        mode = { "n", "v" },
        desc = "Neogit: Reset state",
      },
    },
  },
}
