vim.o.completeopt = 'menuone,noinsert,noselect'

require('compe').setup {
    source = {
        nvim_lsp = true,
        path = true,
        vsnip = true,
    },
}
