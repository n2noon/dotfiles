return {
  "kawre/leetcode.nvim",
  cmd = "Leet",
  build = "TSUpdate html",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    -- "ibhagwan/fzf-lua",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  ---@module 'leetcode'
  ---@type lc.Config
  opts = { lang = "java" },
}
