autocmd BufRead *.vala set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
autocmd BufRead *.vapi set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m

"let vala_ignore_valadoc=1 " Disable valadoc syntax highlight
let vala_comment_strings=1 " Enable comment strings
let vala_space_errors=1 " Highlight space errors
"let vala_no_trail_space_error=1 " Disable trailing space errors
"let vala_no_tab_space_error=1 " Disable space-tab-space errors
"let vala_minlines = 120 " Minimum lines used for comment syncing (default 50)
