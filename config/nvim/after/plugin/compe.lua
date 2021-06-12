vim.o.completeopt = 'menuone,noinsert,noselect,preview'

require('compe').setup {
    preselect = 'disable',
    max_menu_width = 0,
    source = {
        nvim_lsp = true,
        path = true,
        vsnip = true,
    },
}
