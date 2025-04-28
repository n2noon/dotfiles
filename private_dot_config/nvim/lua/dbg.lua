M = {}
---@module "nvim-dap"
---@param dap dap.Configuration
M.adapters = function(dap)
  -- https://github.com/mfussenegger/nvim-dap?tab=readme-ov-file#supported-languages
  -- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
  dap.adapters.codelldb = {
    type = "executable",
    command = "/Users/kalk/.local/share/nvim/mason/packages/codelldb/codelldb",
    name = "lldb",
  }
  dap.configurations.rust = {
    {
      name = "Debug with codelldb",
      type = "codelldb",
      request = "launch",
      program = function()
        return vim.fn.input({
          prompt = "Path to executable: ",
          default = vim.fn.getcwd() .. "/",
          completion = "file",
        })
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
    },
  }
  dap.configurations.python = {
    {
      type = "python",
      request = "launch",
      program = function()
        return vim.fn.input({
          prompt = "Path to executable: ",
          default = vim.fn.getcwd() .. "/",
          completion = "file",
        })
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
    },
  }
end
-- {
--   name = "hello-dap",
--   type = "lldb",
--   request = "launch",
--   program = function() return vim.fn.getcwd() .. "/target/debug/hello-dap" end,
--   cwd = "${workspaceFolder}",
--   stopOnEntry = false,
-- },

return M
