-- see https://github.com/Piotr1215/dotfiles/blob/master/.config/nvim/lua/autocommands.lua

local autocmd = vim.api.nvim_create_autocmd

autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  callback = function() vim.highlight.on_yank() end,
})

autocmd("BufReadPost", {
  desc = "Jump to last edit position when opepning a file",
  pattern = "*",
  callback = function()
    if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
      -- except for in git commit messages
      -- https://stackoverflow.com/questions/31449496/vim-ignore-specifc-file-in-autocommand
      if not vim.fn.expand("%:p"):find(".git", 1, true) then vim.cmd('exe "normal! g\'\\""') end
    end
  end,
})

-- Persistent folds
autocmd("BufWinLeave", {
  pattern = "*.*",
  callback = function() vim.cmd.mkview() end,
})

autocmd("BufWinEnter", {
  pattern = "*.*",
  callback = function() vim.cmd.loadview({ mods = { emsg_silent = true } }) end,
})

-- Auto insert mode for terminals
-- autocmd({ "TermOpen", "TermEnter" }, {
--   callback = function() vim.cmd.startinsert() end,
-- })

-- Show LSP status
-- autocmd("LspProgress", {
--   callback = function()
--     vim.notify(vim.lsp.status(), vim.log.levels.OFF, {
--       id = "lsp_progress",
--       title = "LSP Progress",
--     })
--   end,
-- })

-- Remove auto comment insertion
autocmd("FileType", {
  callback = function() vim.opt.formatoptions:remove({ "o", "r" }) end,
})

-- Open all new windows as vertical splits
vim.api.nvim_create_augroup("numbertoggle", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained" }, {
  callback = function()
    if vim.bo.buftype == "" then
      vim.opt.relativenumber = true
      vim.opt.number = true
    end
  end,
  group = "numbertoggle",
})

vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost" }, {
  callback = function()
    if vim.bo.buftype == "" then
      vim.opt.relativenumber = false
      vim.opt.number = false
    end
  end,
  group = "numbertoggle",
})

-- Shorter columns in text because it reads better that way.
autocmd("FileType", {
  pattern = { "text", "markdown", "mail" },
  command = "setlocal tw=120 cc=120",
})
--
autocmd("FileType", {
  pattern = "gitcommit",
  command = "setlocal tw=72",
})

-- Keep splits the same when nvim is resized.
autocmd("VimResized", {
  command = "wincmd =",
})

-- autocmd({ "BufWinEnter", "BufEnter", "FocusGained" }, {
--   command = "setlocal number relativenumber",
-- })
--
-- autocmd({ "BufWinLeave", "BufLeave", "FocusLost" }, {
--   command = "setlocal nonumber norelativenumber",
-- })

autocmd("FileType", {
  desc = "Open man or help pages in a right split",
  pattern = { "help", "man" },
  -- command = "wincmd L | wincmd 3<",
  command = "wincmd L",
})
