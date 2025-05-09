-- taken from https://github.com/tjdevries/config.nvim/blob/master/lua/custom/plugins/dap.lua
-- look at https://www.reddit.com/r/neovim/comments/1ho7n3v/what_do_you_miss_from_vscode_if_you_even_miss/m48olf9/
return {
  {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      -- { "igorlfs/nvim-dap-view", opts = {} },
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap-python",
    },
    keys = require("keymaps").nvim_dap,
    config = function()
      local dap = require("dap")
      require("dap-python").setup("uv")
      require("dbg").adapters(dap)
      -- NOTE: If using Overseer
      require("overseer").enable_dap()

      --- UI ---
      -- TODO: considering nvim-dap-view instead
      -- local ui = require("dap-view-config")
      local ui = require("dapui")
      -- ---@module "dap.ui"
      -- ---@type dapui.Config
      ui.setup()
      dap.listeners.before.attach.dapui_config = function() ui.open() end
      dap.listeners.before.launch.dapui_config = function() ui.open() end
      dap.listeners.before.event_terminated.dapui_config = function() ui.close() end
      dap.listeners.before.event_exited.dapui_config = function() ui.close() end
    end,
  },
}
