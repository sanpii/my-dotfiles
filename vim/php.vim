set complete=.,w,b,u,t,i,k~/.vim/syntax/php.api
set showfulltag

set omnifunc=phpcomplete#CompletePHP

let php_sql_query=1
let php_htmlInStrings=1
"set tags+=~/.vim/mytags/zend
"set tags+=~/.vim/mytags/doctrine
"set tags+=~/.vim/mytags/magento
"set tags+=~/.vim/mytags/drupal6
set runtimepath+=~/.vim/doc/php

" Symfony2 {{{
" http://knplabs.fr/blog/boost-your-productivity-with-sf2-and-vim

" first set path
set path+=**

" jump to a twig view in symfony
function! s:SfJumpToView()
    mark C
    normal! ]M
    let end = line(".")
    normal! [m
    try
        call search('\v[^.:]+\.html\.twig', '', end)
        normal! gf
    catch
        normal! g`C
        echohl WarningMsg | echomsg "Template file not found" | echohl None
    endtry
endfunction
com! SfJumpToView call s:SfJumpToView()

" create a mapping only in a Controller file
autocmd BufEnter *Controller.php nmap <buffer><leader>v :SfJumpToView<CR>

com! -nargs=* Phpunit make -c /home/mco/ppl/njo/www/app <q-args> | cw

" }}}

