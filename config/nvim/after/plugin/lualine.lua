require('lualine').setup({
    options = {
        theme = 'ayu_dark',
    },
    sections = {
        lualine_b = {},
        lualine_c = { 'filename', 'diagnostics', "require'lsp-status'.status()" },
    },
})
