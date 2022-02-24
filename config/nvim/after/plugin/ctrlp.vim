let g:ctrlp_show_hidden = 0
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn|fingerprint)$',
    \ }
let g:ctrlp_open_new_file = 'r'
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_default_input = 1
let g:ctrlp_extensions = ['funky', 'tag']
let g:ctrlp_prompt_mappings = {
    \ 'PrtSelectMove("j")':   ['<c-t>'],
    \ 'PrtSelectMove("k")':   ['<c-s>'],
    \ 'PrtHistory(-1)':       ['<c-n>'],
    \ 'PrtHistory(1)':        ['<c-p>'],
    \ 'AcceptSelection("t")': ['<Enter>'],
    \ 'AcceptSelection("h")': ['<c-x>', '<c-cr>'],
    \ }
