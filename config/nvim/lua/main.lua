vim.api.nvim_create_augroup('buffer', {clear = true})
vim.api.nvim_create_augroup('filetype', {clear = true})
vim.api.nvim_create_augroup('lsp', {clear = true})

local vimfiles = vim.env.HOME .. '/.config/nvim'

vim.o.mouse = ''
vim.o.fileformats = 'unix'
vim.o.foldmethod = 'marker'
vim.o.number = true
vim.o.relativenumber = true

vim.o.spelllang = 'fr'
vim.o.wrap = false

vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = vimfiles .. '/init.lua',
    command = 'luafile %',
    group = 'buffer',
})

vim.o.textwidth = 80
vim.o.colorcolumn = '+1'
vim.o.cursorline = true

vim.o.inccommand = 'split'

vim.o.splitbelow = true
