augroup filetype
    autocmd FileType * if &ft != 'diff' | autocmd BufWritePre <buffer> StripWhitespace
augroup END
