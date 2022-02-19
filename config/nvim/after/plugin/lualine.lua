require('lualine').setup({
    options = {
        theme = 'ayu_dark',
    },
    sections = {
        lualine_c = { 'filename', "require'lsp-status'.status()" }
    },
})
