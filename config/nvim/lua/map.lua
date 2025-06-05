local map = vim.api.nvim_set_keymap

vim.cmd('cabbrev h vert bo help')

-- http://vim.wikia.com/wiki/Recover_from_accidental_Ctrl-U
map('i', '<c-u>', '<c-g>u<c-u>', {noremap = true})
map('i', '<c-w>', '<c-g>u<c-w>', {noremap = true})

-- Re-selectionner le texte précédemment collé
map('n', '<leader>v', 'V`]', {noremap = true})

map('n', '<leader>ev', ':tabnew $MYVIMRC<CR>', {noremap = true})

map('n', '<leader>P', ':setl paste!<CR>', {noremap = true})
map('n', '<leader>wp', ':setl wrap!<CR>', {noremap = true})
map('n', '<leader>sp', ':setl spell!<CR>', {noremap = true})
map('n', '<leader>h', ':edit %:h<CR>', {noremap = true})

map('i', 'dp', '<esc>', {noremap = true})
map('i', '<esc>', '<nop>', {noremap = true})

map('n', 'B', '^', {noremap = true})
map('n', 'É', '$', {noremap = true})
map('n', 'é', 'w', {noremap = true})
map('n', '$', '<nop>', {noremap = true})
map('n', '^', '<nop>', {noremap = true})

map('n', '<C-l>', ':nohl<CR>:diffupdate<CR>:syntax sync fromstart<CR><C-l>', {noremap = true, silent = true})
