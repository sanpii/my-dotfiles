" Général {{{
    augroup buffer
        autocmd!
    augroup END
    augroup filetype
        autocmd!
    augroup END

    let vimfiles=$HOME . "/.vim"

    exec "source " . vimfiles . "/bundle/pathogen/autoload/pathogen.vim"
    call pathogen#infect()

    " Désactive la compatibilité avec VI
    set nocompatible

    " Encodage en UTF-8
    set encoding=utf-8

    " Accélère le rendu graphique dans les terminaux véloces
    set ttyfast

    " Support du type de format unix uniquement
    set fileformats=unix

    " Détection du type de fichier
    filetype on

    " Désactiver la souris (molette, sélection, etc.)
    set mouse=""

    " N’affiche pas la correspondance des parenthèses
    set noshowmatch

    " Replie de code à l'aide de marqueurs
    set foldmethod=marker

    " Sauvegarde des marqueurs
    if exists('+viewdir')
        augroup buffer
            autocmd BufWinLeave *? silent! mkview
            autocmd BufWinEnter *? silent! loadview
        augroup END
    endif

    " Cacher les tampons quand ils sont abandonnés
    set hidden

    " Ne pas couper les lignes trop longues
    set nowrap

    " Suppression automatique des espaces superflus
    function! StripTrailingWhitespace()
        " Don't strip on these filetypes
        if &ft =~ 'diff'
            return
        endif
        %s/\s\+$//e
    endfunction

    augroup buffer
        autocmd BufWritePre * call StripTrailingWhitespace()
    augroup END

    " .vimrc auto-reload
    augroup buffer
        autocmd bufwritepost .vimrc source %
    augroup END

    " Affiche la limite de 80 caractères
    if v:version >= 703
        set colorcolumn=81
    endif

    set completeopt=longest,menuone
" }}}
" Apparence {{{
    " Coloration syntaxique
    syntax on

    " Thème de couleur pour Vim
    "colorscheme devbox
    "colorscheme vo_dark
    colorscheme desert-warm-256

    " Afficher les caractères spéciaux
    set list listchars=tab:»·,trail:·,precedes:…,extends:…,nbsp:‗
    set showbreak=↪
    highlight NonText cterm=bold ctermfg=darkgrey
    highlight SpecialKey cterm=bold ctermfg=darkgrey

    " Afficher une ligne à la position du curseur
    set cursorline
    highlight CursorLine cterm=bold ctermbg=none gui=bold guibg=grey20

    highlight SpellBad cterm=underline ctermfg=red ctermbg=none
    highlight SpellCap cterm=underline ctermfg=green ctermbg=none
    highlight LanguageToolError cterm=underline ctermfg=green ctermbg=none

    " Nombre de ligne minimal en dessous ou au dessus du curseur
    set scrolloff=3
" }}}
" Indentation {{{
    " Indentation en fonction du type de fichier
    filetype indent on

    " Indispensable pour ne pas tout casser avec ce qui va suivre
    set preserveindent

    " Indentation plus intelligente
    set smartindent

    " Utiliser des tabulations de 4 caractères pour l'indentation
    set noexpandtab

    " Largeur de l'autoindentation
    set shiftwidth=4

    " Arrondit la valeur de l'indentation
    set shiftround

    " Largeur du caractère TAB
    set tabstop=4

    " Largeur de l'indentation de la touche TAB
    set softtabstop=4

    " Remplacer les tabulations par des espaces
    set expandtab

    " Pas d'espace pour les Makefile
    augroup filetype
        autocmd FileType make setlocal noexpandtab
    augroup END

    " Fixing indenting of HTML files
    autocmd FileType html setlocal indentkeys-=*<Return>
" }}}
" Recherches {{{
    " Surligner les résultats de recherche
    set hlsearch

    " Recherches:
    "   - en minuscules = indépendante de la casse
    "   - une majuscule = stricte
    set smartcase

    " Rechercher sans tenir compte de la casse
    " (indépendant du précédent mais de priorité plus faible)
    set ignorecase
" }}}
" Sauvegardes {{{
    set backup
" }}}
" Plugins {{{
    filetype plugin indent on

    " airline {{{
        let g:airline_powerline_fonts = 1
    " }}}
    " cfi {{{
        let g:cfi_php_show_params = 1
    " }}}
    " clam {{{
        nnoremap ! :Clam<space>
        vnoremap ! :ClamVisual<space>
    " }}}
    " ctrlp {{{
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
    " crunch {{{
        noremap <leader>c :CrunchLine<cr>
    " }}}
    " gitv {{{
        let g:Gitv_OpenHorizontal = 1
        let g:Gitv_WrapLines = 0
    " }}}
    " LanguageTool {{{
        let g:languagetool_jar = substitute(system("find ~/.config/libreoffice/3/user/extensions -name LanguageTool.jar"), "\n", "", "g")
    " }}}
    " Text file {{{
        augroup filetype
            autocmd FileType text :source ~/.vim/text.vim
            autocmd FileType tex :source ~/.vim/text.vim
            autocmd FileType markdown :source ~/.vim/text.vim
            autocmd FileType mail :source ~/.vim/mail.vim
        augroup END
    " }}}
    " nerdtree {{{
        nnoremap <silent> <F3> :NERDTreeToggle<CR>
        let NERDTreeQuitOnOpen = 1
        let NERDTreeMapOpenInTab = "<leader>t"
        let NERDTreeMapOpenInTabSilent = "<leader>T"
        let NERDTreeMapOpenVSplit = "<leader>s"
    " }}}
    " piv {{{
        let g:DisableAutoPHPFolding = 1
        let php_folding = 0
    " }}}
    " php-cs-fixer {{{
        let g:php_cs_fixer_path = "~/.applications/bin/php-cs-fixer.phar"
        let g:php_cs_fixer_fixers_list = "indentation,linefeed,trailing_spaces,return,short_tag,unused_use,braces,visibility,phpdoc_params,eof_ending,controls_spaces,elseif"
    " }}}
    " php-namespace {{{
        imap <buffer> <leader>u <C-O>:call PhpInsertUse()<CR>
        map <buffer> <leader>u :call PhpInsertUse()<CR>
    " }}}
    " Seeks {{{
        let g:seeks_node = 'http://seeks.homecomputing.fr'
        let g:seeks_max_results = -1
    " }}}
    " {{{ SingleCompile
        nmap <F9> :SCCompileRun<cr>
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
    " syntastic {{{
        let g:syntastic_auto_loc_list = 2
        let g:syntastic_auto_jump = '1'
        let g:syntastic_php_checkers=['php']
        let g:syntastic_error_symbol = '✗'
        let g:syntastic_warning_symbol = '⚠'
    " }}}
    " {{{ ultisnips
        let g:UltiSnipsExpandTrigger = "<c-e>"
    " }}}
    " vdebug {{{
        let g:vdebug_keymap = {
        \    "run" : "<leader><F5>",
        \    "run_to_cursor" : "<leader><F1>",
        \    "step_over" : "<leader><F2>",
        \    "step_into" : "<leader><F3>",
        \    "step_out" : "<leader><F4>",
        \    "close" : "<leader><F6>",
        \    "detach" : "<leader><F7>",
        \    "set_breakpoint" : "<leader><F10>",
        \    "get_context" : "<leader><F11>",
        \}
    " }}}
    " {{{ YouCompleteMe
        augroup filetype
            autocmd FileType c setlocal omnifunc=ccomplete#Complete
            autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
            autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
            autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
            autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
            autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
            autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
            autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
        augroup end
    " }}}
" }}}
" Mappage {{{
    " Fix meta-keys which generate <Esc>A .. <Esc>z
    if !has('gui_running')
        let c='a'
        while c <= 'z'
            exec "set <M-".c.">=\e".c
            exec "imap \e".c." <M-".c.">"
            let c = nr2char(1+char2nr(c))
        endw
        " Map these two on its own to enable Alt-Shift-J and Alt-Shift-K. If I map the
        " whole spectrum of A-Z, it screws up mouse scrolling somehow. Mouse events
        " must be interpreted as some form of escape sequence that interferes.
        exec 'set <M-J>=J'
        exec 'set <M-K>=K'

        " Tab is mapped to Alt-t, which is mapped from iTerm
        exec 'set <Tab>=t'
    endif

    let mapleader = ","

    " {{{ Help
        function! Help(query)
            let query = expand(a:query)
            if query != ""
                exec ":help " . query
            endif
        endfunction

        inoremap <F1> <Esc> :call Help("<cword>")<CR>
        nnoremap <F1> :call Help("<cword>")<CR>
    " }}}
    " {{{ EndOfLine
        function! s:EndOfLine()
            normal! $
            if getline(".")[col(".")-1] == ';'
                normal! h
            endif
            normal! a
        endfunction

        nnoremap A :call <SID>EndOfLine()<CR>a
    " }}}
    " {{{ RestoreSession
        function! s:RestoreSession()
            if argc() == 0 && filereadable(expand('~/.vimsession'))
                execute 'source ~/.vimsession'
            end
        endfunction

        autocmd VimEnter * call <SID>RestoreSession()
        nnoremap SQ <ESC>:mksession! ~/.vimsession<CR>:wqa<CR>
    " }}}
    " Command line {{{
        cnoremap <c-a> <home>
        cnoremap <c-e> <end>
        cnoremap <c-s> <up>
        cnoremap <c-t> <down>
    " }}}

    " VimTip 436
    inoremap <c-u> <c-g>u<c-u>
    inoremap <c-w> <c-g>u<c-w>

    " simple matching pairs easily, with Tab
    nnoremap <Tab> %

    " Permet de placer au milieu de l'écran l'occurence de la recherche
    nnoremap n nzzzv
    nnoremap N Nzzzv

    nnoremap / /\v

    " Re-selectionner le texte précédemment collé
    nnoremap <leader>v V`]

    nnoremap <leader>ev :vsplit $MYVIMRC<CR>

    nnoremap <leader>p :setl paste!<CR>
    nnoremap <leader>wp :setl wrap!<CR>
    nnoremap <leader>sp :setl spell!<CR>

    inoremap ts <esc>
    inoremap <esc> <nop>

    " Disable arrows. hjkl are a lot faster.
    nnoremap <Up> <nop>
    nnoremap <Down> <nop>
    nnoremap <Left> <nop>
    nnoremap <Right> <nop>

    source ~/.vim/bepo.vim
" }}}

let local_vim=vimfiles . "/local.vim"
if filereadable(local_vim)
    exec "source " . local_vim
endif
