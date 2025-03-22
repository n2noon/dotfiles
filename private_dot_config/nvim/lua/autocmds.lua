-- see https://github.com/Piotr1215/dotfiles/blob/master/.config/nvim/lua/autocommands.lua
local autocmd = vim.api.nvim_create_autocmd

autocmd('ColorScheme', {
    -- pattern = { 'retrobox' },
    callback = function()
        vim.api.nvim_set_hl(0, 'ColorScheme', {cterm=bold, ctermfg=3})

    -- if vim.opt.bg:get() == 'light' then return end
    -- local bg = '#555555'
    -- vim.api.nvim_set_hl(0, 'CurSearch', { fg = '#ffffff', bg = bg, underline = true, bold = true })
    -- vim.api.nvim_set_hl(0, 'Search', { fg = '#ffffff', bg = bg })
    -- vim.cmd 'highlight! link NormalFloat Normal'
    -- vim.cmd 'highlight! link FloatBorder NormalFloat'
    end,
})


autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    callback = function()
        vim.highlight.on_yank()
    end,
})

autocmd('BufReadPost', {
    desc = 'Jump to last edit position when opepning a file',
    pattern = '*',
    callback = function()
        if vim.fn.line '\'"' > 1 and vim.fn.line '\'"' <= vim.fn.line '$' then
            -- except for in git commit messages
            -- https://stackoverflow.com/questions/31449496/vim-ignore-specifc-file-in-autocommand
            if not vim.fn.expand('%:p'):find('.git', 1, true) then
                vim.cmd 'exe "normal! g\'\\""'
            end
        end
    end,
})

autocmd('FileType', {
    desc = 'Open man or help pages in a right split',
    pattern = { 'help', 'man' },
    command = 'wincmd L'
})

-- autocmd({ "BufEnter", "BufRead" }, {
--     desc = 'File associations!',
--     pattern = ".nvimrc",
--     callback = function()
--         vim.bo.filetype = "lua"
--     end,
-- })

-- Persistent folds
autocmd("BufWinLeave", {
  pattern = "*.*",
  callback = function()
    vim.cmd.mkview()
  end,
})
autocmd("BufWinEnter", {
  pattern = "*.*",
  callback = function()
    vim.cmd.loadview({ mods = { emsg_silent = true } })
  end,
})

-- Show LSP status
autocmd("LspProgress", {
    callback = function()
        vim.notify(vim.lsp.status(), vim.log.levels.OFF, {
            id = "lsp_progress",
            title = "LSP Progress",
        })
    end,
})

-- Remove auto comment insertion
autocmd("FileType", {
    callback = function()
        vim.opt.formatoptions:remove({ "o", "r" })
    end
})

-- shorter columns in text because it reads better that way
autocmd('Filetype', {
    pattern = {'text', 'markdown', 'mail'},
    -- command = 'setlocal spell tw=120',
    command = 'setlocal tw=120'
})

autocmd('Filetype', {
    pattern = 'gitcommit',
    -- command = 'setlocal spell tw=72',
    command = 'setlocal tw=72'
})
