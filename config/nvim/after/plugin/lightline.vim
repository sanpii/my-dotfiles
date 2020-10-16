set noshowmode

let g:lightline = {
\     'component_function': {
\         'filename': 'LightlineFilename',
\     },
\ }

function! LightlineFilename()
    return expand('%') !=# '' ? expand('%') : '[No Name]'
endfunction
