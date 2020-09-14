let g:neosnippet#enable_completed_snippet = 0
let g:neosnippet#snippets_directory = ['~/.config/nvim/snippets']

imap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
