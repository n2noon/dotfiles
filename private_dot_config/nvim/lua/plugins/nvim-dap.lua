-- taken from https://github.com/tjdevries/config.nvim/blob/master/lua/custom/plugins/dap.lua
-- look at https://www.reddit.com/r/neovim/comments/1ho7n3v/what_do_you_miss_from_vscode_if_you_even_miss/m48olf9/
return {
  {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
      "williamboman/mason.nvim",
    },
    keys = require("keymaps").nvim_dap,
    config = function()
      local dap = require("dap")
      require("dbg").adapters(dap)
      local ui = require("dapui")
      ui.setup()
      dap.listeners.before.attach.dapui_config = function() ui.open() end
      dap.listeners.before.launch.dapui_config = function() ui.open() end
      dap.listeners.before.event_terminated.dapui_config = function() ui.close() end
      dap.listeners.before.event_exited.dapui_config = function() ui.close() end
    end,
  },
}
