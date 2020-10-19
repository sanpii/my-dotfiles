set shortmess-=s

" https://github.com/wincent/loupe/issues/16
nmap <expr> n (v:searchforward ? "\<Plug>(Loupen)" : "\<Plug>(LoupeN)")
nmap <expr> N (v:searchforward ? "\<Plug>(LoupeN)" : "\<Plug>(Loupen)")
