return {
  "christoomey/vim-tmux-navigator",
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
    "TmuxNavigatePrevious",
    "TmuxNavigatorProcessList",
  },
  keys = {
    { "<left>" , "<cmd>TmuxNavigateLeft<cr>" } ,
    { "<down>" , "<cmd>TmuxNavigateDown<cr>" } ,
    { "<up>"   , "<cmd>TmuxNavigateUp<cr>" }   ,
    { "<right>", "<cmd>TmuxNavigateRight<cr>" },
    { "<c-\\>", "<cmd>TmuxNavigatePrevious<cr>" },
  },
}
