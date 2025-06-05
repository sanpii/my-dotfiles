vim.o.backupdir = vim.fn.stdpath("state") .. '/backup//'

vim.o.backup = true
vim.o.undofile = true

vim.api.nvim_create_autocmd("BufWinLeave", {
    pattern = '*?',
    command = 'silent! mkview',
    group = 'buffer',
})

vim.api.nvim_create_autocmd("BufWinEnter", {
    pattern = '*?',
    command = 'silent! loadview',
    group = 'buffer',
})
