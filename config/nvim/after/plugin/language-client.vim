let g:LanguageClient_serverCommands = {
    \ 'rust': ['rust-analyzer'],
\ }

let g:LanguageClient_useVirtualText = "No"
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
