" Général {{{
    augroup buffer
        autocmd!
    augroup END
    augroup filetype
        autocmd!
    augroup END

    let vimfiles=$HOME . "/.config/nvim"

    set fileformats=unix
    set mouse=""
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
        autocmd bufwritepost $MYVIMRC source %
    augroup END

    set textwidth=80
    set colorcolumn=81

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

    set scrolloff=3
" }}}
" Indentation {{{
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
" Sauvegardes {{{
    let &backupdir=$HOME . "/.local/share/nvim/backup"

    set backup
    set undofile
" }}}
" Plugins {{{
    " airline {{{
        let g:airline_powerline_fonts = 1
        let g:airline#extensions#tabline#enabled = 1
        let g:airline_left_sep = "\uE0B4"
        let g:airline_right_sep = "\uE0B6"
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
    " Gundo {{{
        let g:gundo_prefer_python3 = 1
        nnoremap <leader>u :GundoToggle<cr>
    " }}}
    " Language client {{{
        let g:LanguageClient_serverCommands = {
            \ 'rust': ['rust-analyzer'],
        \ }

        let g:LanguageClient_useVirtualText = "No"
        nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
        nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
        nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
    " }}}
    " Text file {{{
        augroup filetype
            autocmd FileType text :exec "source " . vimfiles . "/text.vim"
            autocmd FileType tex :exec "source " . vimfiles . "/text.vim"
            autocmd FileType markdown :exec "source " . vimfiles . "/text.vim"
        augroup END
    " }}}
    " neosnippet {{{
        let g:neosnippet#enable_completed_snippet = 0
        let g:neosnippet#snippets_directory = ['~/.config/nvim/snippets']

        imap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
        smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
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

    " Don't move on *
    nnoremap <silent> * :let stay_star_view = winsaveview()<cr>*:call winrestview(stay_star_view)<cr>

    " http://vim.wikia.com/wiki/Recover_from_accidental_Ctrl-U
    inoremap <c-u> <c-g>u<c-u>
    inoremap <c-w> <c-g>u<c-w>

    " Re-selectionner le texte précédemment collé
    nnoremap <leader>v V`]

    nnoremap <leader>ev :tabnew $MYVIMRC<CR>

    nnoremap <leader>P :setl paste!<CR>
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
