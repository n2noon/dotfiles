M = {}

M.init = function()
  local m = vim.keymap.set

  m({ "n", "x" }, "<C-/>", "<cmd>normal gcc<cr>", { desc = "Comment line" })
  m({ "n", "x" }, "<C-C>", "<cmd>normal gcc<cr>", { desc = "Comment line" })
  -- clear highlights on search when pressing <Esc> in normal mode (and also dismiss lsp.buf.hover - this is hacky there's probably a better way to do it)
  m("n", "<Esc>", "<cmd>nohlsearch<CR>hl")

  -- always center search results
  m("n", "n", "nzz", { silent = true })
  m("n", "N", "Nzz", { silent = true })
  m("n", "*", "*zz", { silent = true })
  m("n", "#", "#zz", { silent = true })
  m("n", "g*", "g*zz", { silent = true })

  -- search is one key up (nicer on the pinky)
  m({ "n", "x" }, "\\", "/")
  m({ "n", "x" }, "|", "?")

  -- save file
  m({ "n" }, "<Enter>", "<cmd>w<cr><esc>", { desc = "Save File" })

  -- more friendly line begin/end binds
  m({ "n", "x" }, "H", "_")
  m({ "n", "x" }, "L", "$")
  m({ "n", "x" }, ";", ":")

  -- commenting
  m("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
  m("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })

  -- This is different to ciw, you can substitute next word too with n
  m("n", "-", "*Ncgn", { silent = true, desc = "Substitute word under cursor" })

  -- Normal mode Tab alternates buffers
  ---@type vim.keymap.set.Opts
  local nnormap = { silent = true, remap = false }
  m("n", "<C-I>", "<C-I>", nnormap)
  m("n", "<Tab>", ":b#<CR>", nnormap)

  -- ciw shortcut
  m("n", "<Backspace>", "ciw", { silent = true })

  -- make j and k move by visual line, not actual line, when text is soft-wrapped
  -- m('n', 'j', 'gj')
  -- m('n', 'k', 'gk')

  -- More accessible %
  -- m("n", "<leader>e", "%")

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
  { "<leader>p", function() Snacks.picker.files() end, desc = "Find Files" },
  { "<C-P>", function() Snacks.picker.files() end, desc = "Find Files" },
  { "<C-S>", function() Snacks.picker.explorer() end, desc = "Explorer" },
  { "<leader>e", function() Snacks.picker.explorer() end, desc = "Explorer" },
  { "<leader><tab>", function() Snacks.picker.recent() end, desc = "Oldfiles" },
  { "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" },
  { "<leader><leader>", function() Snacks.picker.grep() end, desc = "Grep" },
  { "<C-S-F>", function() Snacks.picker.grep() end, desc = "Grep" },
  { "<leader>;", function() Snacks.picker.command_history() end, desc = "Command History" },
  -- { "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },
  -- find
  { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
  { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
  { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
  { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
  { "<leader>fn", function() Snacks.picker.notifications() end, desc = "Notification History" },
  { "<leader>fs", function() Snacks.picker.smart() end, desc = "Search smart" },
  -- { "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
  -- git
  { "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
  { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
  { "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
  { "<leader>gh", function() Snacks.gitbrowse() end, desc = "Git Browse" },
  { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
  { "<leader>gS", function() Snacks.picker.git_stash() end, desc = "Git Stash" },
  { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
  { "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },
  { "<leader>lg", function() Snacks.lazygit() end, desc = "Lazygit" },
  -- Grep
  { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
  { "<leader>sf", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
  { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
  -- { "<leader>sg", function() Snacks.picker.grep() end, desc = "Grep" },
  { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
  -- search
  { '<leader>s"', function() Snacks.picker.registers() end, desc = "Registers" },
  { "<leader>s/", function() Snacks.picker.search_history() end, desc = "Search History" },
  { "<leader>sa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
  { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
  { "<leader>sc", function() Snacks.picker.command_history() end, desc = "Command History" },
  { "<leader>sC", function() Snacks.picker.commands() end, desc = "Commands" },
  { "<C-S-P>", function() Snacks.picker.commands() end, desc = "Commands" },
  { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
  { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
  { "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
  { "<leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights" },
  { "<leader>si", function() Snacks.picker.icons() end, desc = "Icons" },
  { "<leader>sj", function() Snacks.picker.jumps() end, desc = "Jumps" },
  { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
  { "<leader>sl", function() Snacks.picker.loclist() end, desc = "Location List" },
  { "<leader>sm", function() Snacks.picker.marks() end, desc = "Marks" },
  { "<leader>sM", function() Snacks.picker.man() end, desc = "Man Pages" },
  { "<leader>sp", function() Snacks.picker.lazy() end, desc = "Search for Plugin Spec" },
  { "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
  { "<leader>sR", function() Snacks.picker.resume() end, desc = "Resume" },
  { "<leader>su", function() Snacks.picker.undo() end, desc = "Undo History" },
  { "<leader>sz", function() Snacks.picker.zoxide() end, desc = "Undo History" },
  { "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
  -- LSP
  { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
  { "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
  { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
  { "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
  { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
  { "<leader>o", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
  { "<leader>O", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
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
  { "<leader>st", function() Snacks.picker.todo_comments() end, desc = "Todo" },
  {
    "<leader>sT",
    function() Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } }) end,
    desc = "Todo/Fix/Fixme",
  },
}

M.yazi = {
  -- <C-s> greps inside the directory!
  { "<leader>-", "<cmd>Yazi<cr>", desc = "Open yazi at the current file" },
  { "<leader>_", "<cmd>Yazi cwd<cr>", desc = "Open the file manager in nvim's working directory" },
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
  m("<leader>ca", vim.lsp.buf.code_action, "Code Actions")
  m("<C-.>", vim.lsp.buf.code_action, "Code Actions")
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
  { "<leader>dt", function() require("dap").terminate() end },
  { "<leader>ds", function() require("dap").run() end },
  -- { "<leader>dp", "<cmd>FzfLua dap_configurations<CR>" },
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
