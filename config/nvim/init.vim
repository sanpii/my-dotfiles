" Général {{{
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

    set conceallevel=0
" }}}
" Apparence {{{
    colorscheme desertink

    set list listchars=tab:»·,trail:·,precedes:…,extends:…,nbsp:‗
    set showbreak=↪
    highlight NonText cterm=bold ctermfg=darkgrey
    highlight SpecialKey cterm=bold ctermfg=darkgrey

    set cursorline
    highlight CursorLine cterm=bold ctermbg=236 gui=bold guibg=grey20

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
    " deoplete {{{
        let g:deoplete#enable_at_startup = 1
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
    " Language client {{{
        let g:LanguageClient_serverCommands = {
            \ 'c': ['clangd'],
            \ 'rust': ['rustup', 'run', 'stable', 'rls'],
            \ 'php': ['php', $HOME . '/.local/bin/php-language-server.php'],
        \ }

        let g:LanguageClient_autoStart = 1

        nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
        nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
        nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
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

        set wildignore=data/**,app/cache/**,web/bundles/**,var/**
    " }}}
" }}}
" Mappage {{{
    " Help {{{
        function! Help(query)
            let query = expand(a:query)
            if query != ""
                exec ":vert bo help " . query
            endif
        endfunction

        inoremap <leader><F1> <Esc> :call Help("<cword>")<CR>
        nnoremap <leader><F1> :call Help("<cword>")<CR>
        cabbrev h vert bo help
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

    nnoremap <silent> * :let stay_star_view = winsaveview()<cr>*:call winrestview(stay_star_view)<cr>

    " VimTip 436
    inoremap <c-u> <c-g>u<c-u>
    inoremap <c-w> <c-g>u<c-w>

    " Permet de placer au milieu de l'écran l'occurence de la recherche
    nnoremap <expr> n 'Nn'[v:searchforward] . 'zzzv'
    nnoremap <expr> N 'nN'[v:searchforward] . 'zzzv'

    " Re-selectionner le texte précédemment collé
    nnoremap <leader>v V`]

    nnoremap <leader>ev :tabnew $MYVIMRC<CR>

    nnoremap <leader>p :setl paste!<CR>
    nnoremap <leader>wp :setl wrap!<CR>
    nnoremap <leader>sp :setl spell!<CR>
    nnoremap <leader>h :edit %:h<CR>

    inoremap dp <esc>
    inoremap <esc> <nop>

    nnoremap B ^
    nnoremap É $
    nnoremap é w
    nnoremap $ <nop>
    nnoremap ^ <nop>

    nnoremap <silent> <C-l> :nohl<CR><C-l>
" }}}

let local_vim=vimfiles . "/local.vim"
if filereadable(local_vim)
    exec "source " . local_vim
endif
