-- another comment bind (may change this, it's a bit hacky)
vim.keymap.set({ 'n', 'v' }, '<C-/>', 'gcc')

-- clear highlights on search when pressing <Esc> in normal mode (and also dismiss lsp.buf.hover - this is hacky there's probably a better way to do it)
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>hl')

-- always center search results
vim.keymap.set('n', 'n', 'nzz', { silent = true })
vim.keymap.set('n', 'N', 'Nzz', { silent = true })
vim.keymap.set('n', '*', '*zz', { silent = true })
vim.keymap.set('n', '#', '#zz', { silent = true })
vim.keymap.set('n', 'g*', 'g*zz', { silent = true })

-- more friendly line begin/end binds
vim.keymap.set('n', 'H', '_')
vim.keymap.set('n', 'L', '$')
vim.keymap.set('n', ';', ':')

-- This is different to ciw, you can substitute next word too with n
vim.keymap.set('n', '-', '*Ncgn', { silent = true, desc = 'Substitute word under cursor' })

-- Normal mode Tab alternates buffers
vim.keymap.set('n', '<Tab>', ':b#<CR>', { silent = true })

-- ciw shortcut
vim.keymap.set('n', '<Backspace>', 'ciw', { silent = true })

-- make j and k move by visual line, not actual line, when text is soft-wrapped
-- vim.keymap.set('n', 'j', 'gj')
-- vim.keymap.set('n', 'k', 'gk')

-- More accessible %
vim.keymap.set('n', '<leader>e', '%')

-- Exit terminal mode with double Esc
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- format file (= formats? wow)
vim.keymap.set("n", "<leader>L", "gg=G<C-o>")

--- WINDOW ---
vim.keymap.set('n', '<leader>wq', '<cmd>q<CR>', { desc = 'Quit' })
vim.keymap.set('n', '<leader>wv', ':vsplit<CR>', { desc = 'Vsplit' })
vim.keymap.set('n', '<leader>wh', ':split<CR>', { desc = 'Split' })

-- I'm likely to have these overriden anyway...
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Focus left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Focus right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Focus lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Focus upper window' })

-- Save file with sudo permissions
vim.keymap.set("ca", "w!!", "w !sudo tee % > /dev/null")


--- PLUGINS ---
-- local fzf = require('fzf-lua')
