let g:LanguageClient_serverCommands = {
    \ 'rust': ['rust-analyzer'],
\ }

let g:LanguageClient_useVirtualText = "No"
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

highlight ALEError gui=undercurl guifg=red guibg=none
highlight ALEWarning gui=undercurl guifg=orange guibg=none

let g:LanguageClient_diagnosticsDisplay = {
\     1: {
\         "name": "Error",
\         "texthl": "ALEError",
\         "signText": "",
\         "signTexthl": "ALEErrorSign",
\         "virtualTexthl": "Error",
\     },
\     2: {
\         "name": "Warning",
\         "texthl": "ALEWarning",
\         "signText": "",
\         "signTexthl": "ALEWarningSign",
\         "virtualTexthl": "Todo",
\     },
\     3: {
\         "name": "Information",
\         "texthl": "ALEInfo",
\         "signText": "",
\         "signTexthl": "ALEInfoSign",
\         "virtualTexthl": "Todo",
\     },
\     4: {
\         "name": "Hint",
\         "texthl": "ALEInfo",
\         "signText": "➤",
\         "signTexthl": "ALEInfoSign",
\         "virtualTexthl": "Todo",
\     },
\ }
