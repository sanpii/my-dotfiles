" Général {{{
    let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1

    augroup buffer
        autocmd!
    augroup END
    augroup filetype
        autocmd!
    augroup END

    let vimfiles=$HOME . "/.config/nvim"

    exec "source " . vimfiles . "/bundle/pathogen/autoload/pathogen.vim"
    call pathogen#infect()

    set fileformats=unix
    set mouse=""
    set noshowmatch
    set foldmethod=marker
    set number
    set relativenumber

    if exists('+viewdir')
        augroup buffer
            autocmd BufWinLeave *? silent! mkview
            autocmd BufWinEnter *? silent! loadview
        augroup END
    endif

    set spelllang=fr
    set hidden
    set nowrap

    augroup buffer
        autocmd bufwritepost .vimrc source %
    augroup END

    set textwidth=80

    if v:version >= 703
        set colorcolumn=81
    endif

    set completeopt=longest,menuone
    set wildmode=full
    set inccommand=split
" }}}
" Apparence {{{
    colorscheme desertink

    set list listchars=tab:»·,trail:·,precedes:…,extends:…,nbsp:‗
    set showbreak=↪
    highlight NonText cterm=bold ctermfg=darkgrey
    highlight SpecialKey cterm=bold ctermfg=darkgrey

    set cursorline
    highlight CursorLine cterm=bold ctermbg=none gui=bold guibg=grey20

    highlight SpellBad cterm=underline ctermfg=red ctermbg=none
    highlight SpellCap cterm=underline ctermfg=green ctermbg=none
    highlight LanguageToolError cterm=underline ctermfg=green ctermbg=none

    set scrolloff=3
" }}}
" Indentation {{{
    set preserveindent
    set smartindent
    set shiftwidth=4
    set shiftround
    set tabstop=4
    set softtabstop=4
    set expandtab

    augroup filetype
        autocmd FileType make setlocal noexpandtab
        autocmd FileType html setlocal indentkeys-=*<Return>
    augroup END
" }}}
" Recherches {{{
    set smartcase
    set ignorecase
" }}}
" Sauvegardes {{{
    let &backupdir=$HOME . "/.local/share/nvim/backup"

    set backup
    set undofile
" }}}
" Plugins {{{
    " airline {{{
        let g:airline_powerline_fonts = 1
        let g:airline#extensions#tabline#enabled = 1
    " }}}
    " ale {{{
        let g:ale_sign_column_always = 1
        let g:ale_sign_error = '✗'
        let g:ale_sign_warning = '⚠'
        let g:ale_linters = {'rust': ['rustc']}
    " }}}
    " better-writespace {{{
        augroup filetype
            autocmd FileType * if &ft != 'diff' | autocmd BufWritePre <buffer> StripWhitespace
        augroup END
    " }}}
    " clam {{{
        nnoremap ! :Clam<space>
        vnoremap ! :ClamVisual<space>
    " }}}
    " ctrlp {{{
        let g:ctrlp_show_hidden = 1
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
    " }}}
    " ctrlp-funky {{{
        noremap <C-F> :CtrlPFunky<cr>
    " }}}
    " Grammalecte {{{
        let g:grammalecte_cli_py = '/usr/lib/libreoffice/share/extensions/grammalecte/Grammalecte.py'
    " }}}
    " Indexed search {{{
        let g:indexed_search_show_index_mappings = 0
    " }}}
    " Text file {{{
        augroup filetype
            autocmd FileType text :exec "source " . vimfiles . "/text.vim"
            autocmd FileType tex :exec "source " . vimfiles . "/text.vim"
            autocmd FileType markdown :exec "source " . vimfiles . "/text.vim"
            autocmd FileType mail :exec "source " . vimfiles . "/mail.vim"
        augroup END
    " }}}
    " move {{{
        let g:move_map_keys = 0
        vmap <c-t> <Plug>MoveBlockDown
        vmap <c-s> <Plug>MoveBlockUp
        nmap <c-t> <Plug>MoveLineDown
        nmap <c-s> <Plug>MoveLineUp
    " }}}
    " neosnippet {{{
        let g:neosnippet#enable_completed_snippet = 0
        let g:neosnippet#snippets_directory = ['~/.config/nvim/snippets']

        imap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
        smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
    " }}}
    " pgsql {{{
        let g:sql_type_default = 'pgsql'
    " }}}
    " php-namespace {{{
        imap <buffer> <leader>u <C-O>:call PhpInsertUse()<CR>
        map <buffer> <leader>u :call PhpInsertUse()<CR>
    " }}}
    " php-refactor {{{
        let g:php_refactor_command='refactor.phar'
    " }}}
    " Sideway {{{
        nnoremap <c-c> :SidewaysLeft<cr>
        nnoremap <c-n> :SidewaysRight<cr>
    " }}}
    " SingleCompile {{{
        nmap <F9> :SCCompileRun<cr>
    " }}}
    " Spiffy Foldtext {{{
        let g:SpiffyFoldtext_format = "%c{─}  %<%f{─}┤ %4n lines ├─%l{──}"
    " }}}
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
        augroup buffer
            autocmd BufEnter *Controller.php nmap <buffer><leader>v :SfJumpToView<CR>
        augroup END

        set wildignore=data/**,app/cache/**,web/bundles/**
    " }}}
    " tags {{{
        let g:vim_tags_ignore_files = []
    " }}}
" }}}
" Mappage {{{
    " Help {{{
        function! Help(query)
            let query = expand(a:query)
            if query != ""
                exec ":H " . query
            endif
        endfunction

        inoremap <leader><F1> <Esc> :call Help("<cword>")<CR>
        nnoremap <leader><F1> :call Help("<cword>")<CR>
    " }}}
    " EndOfLine {{{
        function! s:EndOfLine()
            normal! $
            if getline(".")[col(".")-1] == ';'
                normal! h
            endif
            normal! a
        endfunction

        nnoremap A :call <SID>EndOfLine()<CR>a
    " }}}
    " Command line {{{
        cnoremap <c-a> <home>
        cnoremap <c-e> <end>
        cnoremap <c-s> <up>
        cnoremap <c-t> <down>
    " }}}
    " Autoreload firefox {{{
        " https://github.com/bard/mozrepl/wiki/

        function! Refresh_firefox()
            silent !echo  '
                \ if (content.location.href.match(/^http:\/\/localhost/)) {
                \     y = content.window.pageYOffset;
                \     x = content.window.pageXOffset;
                \     BrowserReload();
                \     content.window.scrollTo(x, y);
                \ }
                \ repl.quit();' |
                \ nc -w 1 localhost 4243 2>&1 > /dev/null
        endfunction

        autocmd BufWritePost *.html,*.css,*.js,*.php,*.inc,*.module,*.twig :call Refresh_firefox()
    " }}}

    nnoremap <silent> * :let stay_star_view = winsaveview()<cr>*:call winrestview(stay_star_view)<cr>

    " VimTip 436
    inoremap <c-u> <c-g>u<c-u>
    inoremap <c-w> <c-g>u<c-w>

    " Permet de placer au milieu de l'écran l'occurence de la recherche
    nnoremap <expr> n 'Nn'[v:searchforward] . 'zzzv'
    nnoremap <expr> N 'nN'[v:searchforward] . 'zzzv'

    " Re-selectionner le texte précédemment collé
    nnoremap <leader>v V`]

    nnoremap <leader>ev :vsplit $MYVIMRC<CR>

    nnoremap <leader>p :setl paste!<CR>
    nnoremap <leader>wp :setl wrap!<CR>
    nnoremap <leader>sp :setl spell!<CR>

    inoremap dp <esc>
    inoremap <esc> <nop>

    nnoremap B ^
    nnoremap É $
    nnoremap é w
    nnoremap $ <nop>
    nnoremap ^ <nop>
" }}}

let local_vim=vimfiles . "/local.vim"
if filereadable(local_vim)
    exec "source " . local_vim
endif
