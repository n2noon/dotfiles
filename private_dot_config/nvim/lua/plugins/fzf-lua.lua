return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = require("keymaps").fzflua,
  opts = {
    -- see https://github.com/ibhagwan/fzf-lua?tab=readme-ov-file#customization
    defaults = {
      file_icons = false,
      winopts = {
        height = 0.95,
        width = 0.93,
        border = "double",
        preview = { title_pos = "left" },
        number = false,
        relativenumber = false
      },
      previewer = bat_async
    },
    -- VSCode-like file name first
    files = {
      formatter = "path.filename_first",
      file_icons = false,
      winopts = {},
    },
    blines = { previewer = false, winopts = { row = 0.4, height = 0.9, width = 0.8 } },
    oldfiles = {
      formatter = "path.filename_first",
      include_current_session = true,
    },
    code_actions = {
      -- requires git-delta
      previewer = "codeaction_native",
    },
    lsp = {
      -- see https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#symbolKind
      symbols = {
        symbol_style = 2,
        symbol_fmt = function(s) return s end,
      },
    },
  },
}
