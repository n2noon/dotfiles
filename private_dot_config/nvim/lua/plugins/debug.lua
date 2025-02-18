-- taken from https://github.com/tjdevries/config.nvim/blob/master/lua/custom/plugins/dap.lua
-- look at https://www.reddit.com/r/neovim/comments/1ho7n3v/what_do_you_miss_from_vscode_if_you_even_miss/m48olf9/
return {
  {
    'mfussenegger/nvim-dap',
    event = "VeryLazy",
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'theHamsta/nvim-dap-virtual-text',
      'nvim-neotest/nvim-nio',
      'williamboman/mason.nvim',
    },
    config = function()
      local dap = require 'dap'
      local ui = require 'dapui'

      require('dapui').setup()

      vim.keymap.set('n', '<leader>da', dap.toggle_breakpoint, {desc = "Toggle breakpoint"})
      vim.keymap.set('n', '<leader>dl', dap.run_to_cursor)

      -- Eval var under cursor
      vim.keymap.set('n', '<space>?', function()
        require('dapui').eval(nil, { enter = true })
      end)

      vim.keymap.set('n', '<leader>dc', dap.continue)
      vim.keymap.set('n', '<leader>di', dap.step_into)
      vim.keymap.set('n', '<leader>dv', dap.step_over)
      vim.keymap.set('n', '<leader>do', dap.step_out)
      vim.keymap.set('n', '<leader>db', dap.step_back)
      vim.keymap.set('n', '<leader>dr', dap.restart)
      vim.keymap.set('n', '<leader>dp', '<cmd>FzfLua dap_configurations<CR>')


      dap.adapters.lldb = {
        type = "executable",
        command = "/Users/kalk/.local/share/nvim/mason/packages/codelldb",
        name = "lldb",
      }

      dap.configurations.rust = {
        {
          name = "hello-dap",
          type = "lldb",
          request = "launch",
          program = function()
              return vim.fn.getcwd() .. "/target/debug/hello-dap"
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
      }

      dap.listeners.before.attach.dapui_config = function() ui.open() end
      dap.listeners.before.launch.dapui_config = function() ui.open() end
      dap.listeners.before.event_terminated.dapui_config = function() ui.close() end
      dap.listeners.before.event_exited.dapui_config = function() ui.close() end
    end,
  }
}
