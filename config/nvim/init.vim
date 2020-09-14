" Général {{{
    augroup buffer
        autocmd!
    augroup END
    augroup filetype
        autocmd!
    augroup END

    let vimfiles=$HOME . "/.config/nvim"

    set fileformats=unix
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

    set inccommand=split
" }}}
" Apparence {{{
    colorscheme desertink

    set list
    set listchars=tab:»·,trail:·,precedes:…,extends:…,nbsp:‗
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
