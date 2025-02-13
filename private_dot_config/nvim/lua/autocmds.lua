-- see https://github.com/Piotr1215/dotfiles/blob/master/.config/nvim/lua/autocommands.lua
--
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd('BufReadPost', {
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

vim.api.nvim_create_autocmd('FileType', {
  desc = 'Open man or help pages in a right split',
  pattern = {'help', 'man'},
  callback = function()
    vim.cmd 'wincmd L'
  end
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufRead" }, {
  desc = 'File associations!',
  pattern = ".nvimrc",
  callback = function()
    vim.bo.filetype = "lua"
  end,
})
