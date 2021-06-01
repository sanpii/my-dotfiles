let g:vsnip_snippet_dir = "~/.config/nvim/snippets"

imap <expr> <tab> vsnip#expandable() ? '<Plug>(vsnip-expand)' : (vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<tab>')
smap <expr> <Tab> vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'
