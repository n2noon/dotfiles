M = {}

M.init = function()
  local m = vim.keymap.set
  -- another comment bind (may change this, it's a bit hacky)
  m({ "n", "v" }, "<C-/>", "gcc")

  -- clear highlights on search when pressing <Esc> in normal mode (and also dismiss lsp.buf.hover - this is hacky there's probably a better way to do it)
  m("n", "<Esc>", "<cmd>nohlsearch<CR>hl")

  -- always center search results
  m("n", "n", "nzz", { silent = true })
  m("n", "N", "Nzz", { silent = true })
  m("n", "*", "*zz", { silent = true })
  m("n", "#", "#zz", { silent = true })
  m("n", "g*", "g*zz", { silent = true })

  -- save file
  m({ "n" }, "<Enter>", "<cmd>w<cr><esc>", { desc = "Save File" })

  -- more friendly line begin/end binds
  m("n", "H", "_")
  m("n", "L", "$")
  m("n", ";", ":")

  -- commenting
  m("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
  m("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })

  -- This is different to ciw, you can substitute next word too with n
  m("n", "-", "*Ncgn", { silent = true, desc = "Substitute word under cursor" })

  -- Normal mode Tab alternates buffers
  m("n", "<Tab>", ":b#<CR>", { silent = true })

  -- ciw shortcut
  m("n", "<Backspace>", "ciw", { silent = true })

  -- make j and k move by visual line, not actual line, when text is soft-wrapped
  -- m('n', 'j', 'gj')
  -- m('n', 'k', 'gk')

  -- More accessible %
  m("n", "<leader>e", "%")

  -- Exit terminal mode with double Esc
  m("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

  -- format file (= formats? wow)
  m("n", "<leader>L", "gg=G<C-o>")

  --- WINDOW ---
  m("n", "<leader>wq", "<cmd>q<CR>", { desc = "Quit" })
  m("n", "<leader>wv", ":vsplit<CR>", { desc = "Vsplit" })
  m("n", "<leader>wh", ":split<CR>", { desc = "Split" })
  -- Resize window using <ctrl> arrow keys
  -- m("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
  -- m("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
  -- m("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
  -- m("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

  -- Move Lines
  m("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
  m("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
  m("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
  m("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
  m("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
  m("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

  m("n", "<C-h>", "<C-w><C-h>", { desc = "Focus left window" })
  m("n", "<left>", "<C-w><C-h>", { desc = "Focus left window" })
  m("n", "<C-l>", "<C-w><C-l>", { desc = "Focus right window" })
  m("n", "<right>", "<C-w><C-l>", { desc = "Focus right window" })
  m("n", "<C-j>", "<C-w><C-j>", { desc = "Focus lower window" })
  m("n", "<down>", "<C-w><C-j>", { desc = "Focus lower window" })
  m("n", "<C-k>", "<C-w><C-k>", { desc = "Focus upper window" })
  m("n", "<up>", "<C-w><C-k>", { desc = "Focus upper window" })

  -- Save file with sudo permissions
  m("ca", "w!!", "w !sudo tee % > /dev/null")
end

--- PLUGINS ---
M.snacks = {
  { "<leader>N", function() Snacks.rename.rename_file() end, desc = "Rename File" },
}

M.conform = {
  {
    "<leader>cf",
    function()
      require("conform").format({
        formatters = { "injected" },
        timeout_ms = 3000,
      })
    end,
    mode = { "n", "v" },
    desc = "Format Injected Langs",
  },
}

-- NAVIGATION --
M.fzflua = {
  { "<c-p>", function() FzfLua.files() end, desc = "Open File" },
  { "<c-s-p>", function() FzfLua.commands() end, desc = "Open Commands" },
  { "<leader>f", function() FzfLua.blines() end, desc = "Search Buffer" },
  { "<leader>sf", function() FzfLua.blines() end, desc = "Search Buffer" },
  { "<leader><leader>f", function() FzfLua.live_grep_glob() end, desc = "Search Everywhere" },
  { "<leader><Tab>", function() FzfLua.oldfiles() end, desc = "Recent Files" },
  { "<leader>m", function() FzfLua.marks() end, desc = "[M]arks" },
  { "<leader>sh", function() FzfLua.helptags() end, desc = "[S]earch [H]elp" },
  { "<leader>sk", function() FzfLua.keymaps() end, desc = "[S]earch keymaps?" },
  { "<leader>sm", function() FzfLua.manpages() end, desc = "[S]earch [M]an pages" },
  { "<leader>sw", function() FzfLua.grep_cword() end, desc = "[S]earch [w]ord" },
  { "<leader>st", "<cmd>TodoFzfLua<CR>", desc = "Search [T]ODO" },
  { "<leader>z", function() FzfLua.zoxide() end, desc = "[Z]oxide" },
}
M.todocomments = {
  { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
  { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
}
M.yazi = {
  -- <C-s> greps inside the directory!
  { "<leader>-", "<cmd>Yazi<cr>", desc = "Open yazi at the current file" },
  { "<leader>cw", "<cmd>Yazi cwd<cr>", desc = "Open the file manager in nvim's working directory" },
}
M.smartcd = { { "<leader>cd" } }

-- LSP --
M.ext_lsp = function(event, fzflua)
  local m = function(keys, func, desc, mode)
    mode = mode or "n"
    vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "FZF-LSP: " .. desc })
  end
  m("grr", fzflua.lsp_references, "[G]oto [R]eferences")
  m("gi", fzflua.lsp_implementations, "[G]oto [I]mplementation")
  m("gd", fzflua.lsp_definitions, "[G]oto [D]efinition")
  m("gD", fzflua.lsp_declarations, "[G]oto [D]eclaration")
  m("gt", fzflua.lsp_typedefs, "[G]oto [T]ype")
  m("gra", fzflua.lsp_code_actions, "Code Action", { "n", "x" })
  m("<C-.>", fzflua.lsp_code_actions, "Code Action", { "n", "x" })
  m("<leader>o", fzflua.lsp_document_symbols, "Symb[o]ls")
  -- Diagnostics
  m("<leader>q", fzflua.lsp_document_diagnostics, "Diagnosti[q]s [L]ist")
  m("<leader><leader>q", fzflua.lsp_workspace_diagnostics, "Diagnosti[q]s [W]orkspace")
end

M.lsp = function(event)
  local m = function(keys, func, desc, mode)
    mode = mode or "n"
    vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
  end
  m("gh", vim.lsp.buf.hover, "Show hover")
  m("<leader>n", vim.lsp.buf.rename, "Re[n]ame")
end

-- DEBUG --
M.nvim_dap = {
  { "<leader>da", function() require("dap").toggle_breakpoint() end, desc = "Toggle breakpoint" },
  { "<leader>dl", function() require("dap").run_to_cursor() end },
  { "<leader>dc", function() require("dap").continue() end },
  { "<leader>di", function() require("dap").step_into() end },
  { "<leader>dv", function() require("dap").step_over() end },
  { "<leader>do", function() require("dap").step_out() end },
  { "<leader>db", function() require("dap").step_back() end },
  { "<leader>dr", function() require("dap").restart() end },
  { "<leader>dp", "<cmd>FzfLua dap_configurations<CR>" },
  -- Eval var under cursor
  { "<space>?", function() require("dapui").eval(nil, { enter = true }) end },
}

return M
-- {
--   "<leader>uw",
--   function()
--     Snacks.toggle.option("wrap", { name = "Wrap" })
--   end,
--   desc = "Toggle wrap",
-- },
-- Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
-- Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
-- Snacks.toggle.diagnostics():map("<leader>ud")
-- Snacks.toggle.line_number():map("<leader>ul")
-- if vim.lsp.inlay_hint then
--   Snacks.toggle.inlay_hints():map("<leader>uh")
-- end
-- {
--   "<leader>g",
--   function()
--     Snacks.lazygit()
--   end,
--   desc = "Lazygit",
-- },
-- { '<leader>..', function() Snacks.scratch() end, desc = 'Toggle Scratch Buffer', },
-- { '<leader>.,', function() Snacks.scratch.select() end, desc = 'Select Scratch Buffer', },
-- { "<c-'>", function() Snacks.terminal() end, desc = 'Toggle Terminal', },
-- { '<leader>§', function() Snacks.terminal() end, desc = 'Toggle Terminal', },

-- Snacks options
-- Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
-- Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2, name = "Conceal Level" }):map("<leader>uc")
-- Snacks.toggle.treesitter():map("<leader>uT")
-- Snacks.toggle.option("background", { off = "light", on = "dark" , name = "Dark Background" }):map("<leader>ub")
-- Snacks.toggle.profiler():map("<leader>dpp")
-- Snacks.toggle.profiler_highlights():map("<leader>dph")
