local g = vim.g
local o = vim.o

-- Use ripgrep for vimgrep
vim.opt.grepprg = "rg --vimgrep --smart-case --no-heading"
vim.opt.grepformat = "%f:%l:%c:%m"

if g.neovide then
  o.guifont = "JetBrainsMonoNL Nerd Font Mono:h16"
  g.neovide_cursor_animate_command_line = false
  g.neovide_cursor_animate_in_insert_mode = false
  g.neovide_cursor_animation_length = 0
  g.neovide_cursor_animation_length = 0.00
  g.neovide_cursor_trail_size = 0
  g.neovide_position_animation_length = 0
  g.neovide_position_animation_length = 0.05
  g.neovide_scale_factor = 1.0
  g.neovide_scroll_animation_far_lines = 0
  g.neovide_scroll_animation_length = 0
  g.neovide_scroll_animation_length = 0.00
  local change_scale_factor = function(delta) vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta end
  vim.keymap.set("n", "<C-=>", function() change_scale_factor(1.05) end)
  vim.keymap.set("n", "<C-->", function() change_scale_factor(1 / 1.05) end)
  g.neovide_input_macos_option_key_is_meta = "only_left"
end

g.mapleader = " "
g.maplocalleader = " "
g.snacks_animate = false

o.title = true
-- o.number = true
o.relativenumber = true
o.wrap = false
o.mouse = "a"
o.showmode = false
-- o.breakindent = true
o.winborder = "single"
o.undofile = true
o.ignorecase = true
o.smartcase = true -- Override case insensitive search if capitals present
o.signcolumn = "yes:1"
o.splitbelow = true
o.splitright = true
o.list = true -- Sets how neovim will display certain whitespace characters
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.wildignore:append({ ".DS_Store" })
o.inccommand = "split" -- Preview substitutions live
o.cursorline = true
o.scrolloff = 8 -- Minimal number of screen lines to keep above and below the cursor.
o.softtabstop = 4
o.shiftwidth = 4
o.conceallevel = 1
o.expandtab = true
o.shada = "'1000,f1,<500"
o.updatetime = 700
o.spell = false

-- Folding
-- o.foldmethod = "expr"
-- o.foldexpr = "v:lua.Foldexpr()"
-- o.foldcolumn = "0"
-- o.foldtext = ""
-- o.foldlevel = 99
-- o.foldlevelstart = 10
-- o.foldnestmax = 4

-- o.timeoutlen = 400 -- Displays which-key popup sooner
-- This is delayed so startup time is quicker
vim.schedule(function() o.clipboard = "unnamedplus" end)

-- vim.diagnostic.config({
--   -- virtual_text = true
--   virtual_lines = {current_line = true},
--   update_in_insert = false,
--   underline = true
-- })

-- https://www.reddit.com/r/neovim/comments/1jm5atz/replacing_vimdiagnosticopen_float_with_virtual/mk9w6v0/
---@param jumpCount number
local function jumpWithVirtLineDiags(jumpCount)
  pcall(vim.api.nvim_del_augroup_by_name, "jumpWithVirtLineDiags") -- prevent autocmd for repeated jumps

  vim.diagnostic.jump({ count = jumpCount })

  local initialVirtTextConf = vim.diagnostic.config().virtual_text
  vim.diagnostic.config({
    virtual_text = false,
    virtual_lines = { current_line = true },
  })

  vim.defer_fn(function() -- deferred to not trigger by jump itself
    vim.api.nvim_create_autocmd("CursorMoved", {
      desc = "User(once): Reset diagnostics virtual lines",
      once = true,
      group = vim.api.nvim_create_augroup("jumpWithVirtLineDiags", {}),
      callback = function() vim.diagnostic.config({ virtual_lines = false, virtual_text = initialVirtTextConf }) end,
    })
  end, 1)
end

vim.keymap.set("n", "]d", function() jumpWithVirtLineDiags(1) end, { desc = "󰒕 Next diagnostic" })
vim.keymap.set("n", "[d", function() jumpWithVirtLineDiags(-1) end, { desc = "󰒕 Prev diagnostic" })
