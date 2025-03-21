require('grug-far').setup({
    windowCreationCommand = 'tab split',
    startInInsertMode = false,
    openTargetWindow = {
        preferredLocation = 'right',
    },
})

vim.keymap.set('n', '<leader>ff', '<cmd>GrugFar<cr>')
