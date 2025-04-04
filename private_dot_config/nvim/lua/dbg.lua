M = {}

-- https://github.com/mfussenegger/nvim-dap?tab=readme-ov-file#supported-languages

M.adapters = function(dap)
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
      program = function() return vim.fn.getcwd() .. "/target/debug/hello-dap" end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
    },
  }
end

return M
