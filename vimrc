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

    " Afficher une liste lors de complétion de commandes/fichiers
    set wildmenu

    " Désactiver la souris (molette, sélection, etc.)
    set mouse=""

    " Afficher des infos dans la barre de statut
    set laststatus=2

    " Afficher la position du curseur
    set ruler

    " Afficher partiellement la commande dans la ligne de statut
    set showcmd

    " Afficher la correspondance des parenthèses
    set noshowmatch

    " Replie de code à l'aide de marqueurs
    set foldmethod=marker

    " Sauvegarde des marqueurs
    let view_dir=vimfiles . "/view"
    if isdirectory(view_dir)
        exec "set viewdir=" . view_dir
        augroup buffer
            autocmd BufWinLeave *? silent! mkview
            autocmd BufWinEnter *? silent! loadview
        augroup END
    endif
    unlet view_dir

    " Cacher les tampons quand ils sont abandonnés
    set hidden

    " Nombre de commandes maximale dans l'historique
    set history=100

    " Ne pas couper les lignes trop longues
    set nowrap

    " Suppression automatique des espaces superflus
    augroup buffer
        autocmd BufWritePre * :%s/\s\+$//e
    augroup END

    " .vimrc auto-reload
    augroup buffer
        autocmd bufwritepost .vimrc source %
    augroup END

    " Permettre l'utilisation de la touche backspace dans tous les cas
    set backspace=2

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

    " Idem sur les côtés
    set sidescrolloff=3
" }}}
" Indentation {{{
    " Indentation en fonction du type de fichier
    filetype indent on

    " Indispensable pour ne pas tout casser avec ce qui va suivre
    set preserveindent

    " Activer l'indentation automatique
    set autoindent

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
" }}}
" Correction orthographique {{{
    " version Nemolivier
    set nospell spelllang=fr

    " automatique pour les fichiers tex
    augroup filetype
        autocmd FileType tex setlocal spell spelllang=fr
    augroup END
" }}}
" Recherches {{{
    " Utiliser la recherche incrémentielle
    set incsearch

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
    let backup_dir=vimfiles . "/backup"
    if isdirectory(backup_dir)
        " répertoire de sauvegarde automatique
        exec "set backupdir=" . backup_dir

        " activation de la sauvegarde
        set backup
    endif
    unlet backup_dir

    if v:version >= 703
        let undo_dir=vimfiles . "/undo"
        if isdirectory(undo_dir)
            " répertoire de sauvegarde automatique
            exec "set undodir=" . undo_dir

            " activation de la sauvegarde
            set undofile
        endif
        unlet undo_dir
    endif
" }}}
" Mappage {{{
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
    " {{{ GrepOperator
        function! s:GrepOperator(type)
            let saved_unnamed_register = @@

            if a:type ==# 'v'
                normal! `<v`>y
            elseif a:type ==# 'char'
                normal! `[v`]y
            else
                return
            endif

            execute ":grep! " . shellescape(@@)
            copen

            let @@ = saved_unnamed_register
        endfunction

        nnoremap <leader>g :set operatorfunc=<SID>GrepOperator<cr>g@
        vnoremap <leader>g :<c-u>call <SID>GrepOperator(visualmode())<cr>
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
    " {{{ Spell
        noremap <F10> :set spell!<CR>
        inoremap <F10> <Esc> :set spell!<CR>
        vnoremap <F10> <Esc> :set spell!<CR>
    " }}}

    " simple matching pairs easily, with Tab
    map <Tab> %

    " Permet de placer au milieu de l'écran l'occurence de la recherche
    nnoremap n nzzzv
    nnoremap N Nzzzv

    nnoremap // :nohlsearch<CR>
    nnoremap / /\v

    " Re-selectionner le texte précédemment collé
    nnoremap <leader>v V`]

    nnoremap <leader>ev :vsplit $MYVIMRC<CR>

    nnoremap <leader>p :setl paste!<CR>
    nnoremap <leader>w :setl wrap!<CR>

    inoremap ts <esc>
    inoremap <esc> <nop>

    " Disable arrows. hjkl are a lot faster.
    nnoremap <Up> <nop>
    nnoremap <Down> <nop>
    nnoremap <Left> <nop>
    nnoremap <Right> <nop>

    source ~/.vim/bepo.vim
" }}}
" Plugins {{{
    filetype plugin indent on

    " cfi {{{
        let g:cfi_php_show_params = 1
    " }}}
    " ctrlp {{{
        noremap <C-i> :CtrlPTag<CR>
        let g:ctrlp_clear_cache_on_exit = 0
        let g:ctrlp_default_input = 1
        let g:ctrlp_extensions = ['tag', 'buffertag']
    " }}}
    " dwm {{{
        let g:dwm_map_keys = 0
        let g:dwm_master_pane_width = 85

        nnoremap <C-T> <C-W>w
        nnoremap <C-S> <C-W>W

        nmap <C-S-T> <Plug>DWMRotateCounterclockwise
        nmap <C-S-S> <Plug>DWMRotateClockwise

        nmap <C-N> <Plug>DWMNew
        nmap <C-X> <Plug>DWMClose
        nmap <C-Space> <Plug>DWMFocus

        nmap <C-R> <Plug>DWMGrowMaster
        nmap <C-C> <Plug>DWMShrinkMaster
    " }}}
    " easytags {{{
        set tags=./tags
        let g:easytags_dynamic_files = 2
        let g:easytags_include_members = 1
    " }}}
    " gitv {{{
        let g:Gitv_OpenHorizontal = 1
        let g:Gitv_WrapLines = 0
    " }}}
    " LanguageTool {{{
        let g:languagetool_jar = substitute(system("find ~/.config/libreoffice/3/user/extensions -name LanguageTool.jar"), "\n", "", "g")
    " }}}
    " mail {{{
        augroup filetype
            autocmd FileType mail :source ~/.vim/mail.vim
            autocmd FileType mkd :source ~/.vim/mail.vim
        augroup END
    " }}}
    " multiedit {{{
        let g:multiedit_nomappings = 1
    " }}}
    " neocomplcache {{{
        " Disable AutoComplPop.
        let g:acp_enableAtStartup = 0
        " Use neocomplcache.
        let g:neocomplcache_enable_at_startup = 1
        " Use smartcase.
        let g:neocomplcache_enable_smart_case = 1
        " Use camel case completion.
        let g:neocomplcache_enable_camel_case_completion = 1
        " Use underbar completion.
        let g:neocomplcache_enable_underbar_completion = 1
        " Set minimum syntax keyword length.
        let g:neocomplcache_min_syntax_length = 3
        let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

        " Define dictionary.
        let g:neocomplcache_dictionary_filetype_lists = {
            \ 'default' : '',
            \ }

        " Define keyword.
        if !exists('g:neocomplcache_keyword_patterns')
          let g:neocomplcache_keyword_patterns = {}
        endif
        let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

        " Plugin key-mappings.
        imap <C-k> <Plug>(neocomplcache_snippets_expand)
        smap <C-k> <Plug>(neocomplcache_snippets_expand)
        inoremap <expr><C-g> neocomplcache#undo_completion()
        inoremap <expr><C-l> neocomplcache#complete_common_string()

        " SuperTab like snippets behavior.
        "imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

        " Recommended key-mappings.
        " <CR>: close popup and save indent.
        inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
        " <TAB>: completion.
        inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
        " <C-h>, <BS>: close popup and delete backword char.
        inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
        inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
        inoremap <expr><C-y>  neocomplcache#close_popup()
        inoremap <expr><C-e>  neocomplcache#cancel_popup()

        " AutoComplPop like behavior.
        "let g:neocomplcache_enable_auto_select = 1

        " Shell like behavior(not recommended).
        "set completeopt+=longest
        "let g:neocomplcache_enable_auto_select = 1
        "let g:neocomplcache_disable_auto_complete = 1
        "inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<TAB>"
        "inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"

        " Enable omni completion.
        augroup filetype
            autocmd FileType c setlocal omnifunc=ccomplete#Complete
            autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
            autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
            autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
            autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
            autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
            autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
        augroup END

        " Enable heavy omni completion.
        if !exists('g:neocomplcache_omni_patterns')
          let g:neocomplcache_omni_patterns = {}
        endif
        let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
        let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
        let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
        let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'
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
    " Powerline {{{
        let g:Powerline_symbols = 'fancy'
    " }}}
    " Seeks {{{
        let g:seeks_node = 'http://seeks.homecomputing.fr'
        let g:seeks_max_results = -1
    " }}}
    " {{{ SingleCompile
        nmap <F9> :SCCompileRun<cr>
    " }}}
    " Snipmate {{{
        let g:snipMate = {}
        let g:snipMate.scope_aliases = {}
        let g:snipMate.scope_aliases['php'] = 'php,sf2'
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
        let g:syntastic_auto_jump = 1
        let g:syntastic_phpcs_disable = 1
        let g:syntastic_error_symbol = '✗'
        let g:syntastic_warning_symbol = '⚠'
    " }}}
    " tagbar {{{
        nmap <F8> :TagbarToggle<CR>
        let g:tagbar_autoclose=1
        let g:tagbar_autofocus=1

        let g:tagbar_type_php = {
            \ 'ctagstype' : 'php',
            \ 'kinds' : [
                \ 'i:interfaces',
                \ 'c:classes',
                \ 'd:constant definitions',
                \ 'f:functions',
                \ 'j:javascript functions:1'
            \ ]
          \ }
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
" }}}

let local_vim=vimfiles . "/local.vim"
if filereadable(local_vim)
    exec "source " . local_vim
endif
