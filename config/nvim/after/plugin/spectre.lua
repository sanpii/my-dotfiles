local spectre = require('spectre')

spectre.setup({
        open_cmd = 'buffer',
})

vim.keymap.set('n', '<leader>ff', spectre.open, {})
