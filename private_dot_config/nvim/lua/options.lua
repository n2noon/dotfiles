local g = vim.g
local o = vim.o

g.mapleader = ' '
g.maplocalleader = ' '

o.title = true
o.number = true
o.relativenumber = true
o.wrap = false
o.mouse = 'a'
o.showmode = false
-- o.breakindent = true
o.undofile = true
o.laststatus = 1
o.ignorecase = true
o.smartcase = true -- Override case insensitive search if capitals present
o.signcolumn = 'yes:1'
o.splitbelow = true
o.splitright = true
o.list = true -- Sets how neovim will display certain whitespace characters
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
o.inccommand = 'split' -- Preview substitutions live
o.cursorline = true
o.scrolloff = 8 -- Minimal number of screen lines to keep above and below the cursor.
o.softtabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.shada = "'1000,f1,<500"
o.updatetime = 700

-- Folding
o.foldmethod = "expr"
o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
o.foldcolumn = "0"
o.foldtext = ""
o.foldlevel = 99
-- o.foldlevelstart = 10
-- o.foldnestmax = 4


-- o.timeoutlen = 400 -- Displays which-key popup sooner
-- This is delayed so startup time is quicker
vim.schedule(function()
  o.clipboard = 'unnamedplus'
end)

