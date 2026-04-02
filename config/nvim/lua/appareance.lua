vim.cmd('colorscheme tango-dark')

require('vim._core.ui2').enable()

vim.o.list = true
vim.o.listchars='tab:»·,trail:·,precedes:…,extends:…,nbsp:‗'
vim.o.showbreak='↪'
vim.o.scrolloff=3
vim.o.sidescrolloff=5
vim.opt.fillchars:append {eob = ' '}
