" Général {{{
    call pathogen#infect()

    let vimfiles=$HOME . "/.vim"

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
        autocmd BufWinLeave *? mkview
        autocmd BufWinEnter *? silent loadview
    endif
    unlet view_dir

    " Cacher les tampons quand ils sont abandonnés
    set hidden

    " Nombre de commandes maximale dans l'historique
    set history=100

    " Ne pas couper les lignes trop longues
    set nowrap

    " Suppression automatique des espaces superflus
    autocmd BufWritePre * :%s/\s\+$//e

    " Permettre l'utilisation de la touche backspace dans tous les cas
    set backspace=2

    " Affiche la limite de 80 caractères
    if v:version >= 703
        set colorcolumn=81
    endif

    " Omni-completion
    autocmd FileType python set omnifunc=pythoncomplete#Complete
    autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
    autocmd FileType css set omnifunc=csscomplete#CompleteCSS
    autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
    autocmd FileType c set omnifunc=ccomplete#Complete

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
    autocmd FileType make setlocal noexpandtab
" }}}

" Correction orthographique {{{
    " version Nemolivier
    set nospell spelllang=fr

    " automatique pour les fichiers tex
    augroup filetypedetect
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

    function! Help(query)
        let query = expand(a:query)
        if query != ""
            exec ":help " . query
        endif
    endfunction

    " Help
    inoremap <F1> <Esc> :call Help("<cword>")<CR>
    nnoremap <F1> :call Help("<cword>")<CR>

    " Exécuter le fichier actuel dans le navigateur
    function! Browser(uri)
        let uri=a:uri

        if uri == ""
            let uri=expand("%:p")
        endif
        exec ":silent !x-www-browser ".uri
        redraw!
    endfunction

    " Exécuter le fichier
    autocmd FileType python map <F9> :!python "%"<CR>
    autocmd FileType c map <F9> :!gcc -o "%:r" % && ./%:r<CR>
    autocmd FileType vala map <F9> :!valac "%" && ./%:r<CR>
    autocmd FileType genie map <F9> :!valac "%" && ./%:r<CR>
    autocmd FileType tex map <F9> :!pdflatex "%" && see "%:r.pdf"<CR>
    autocmd FileType php map <F9> :!php "%"<CR>
    autocmd FileType html map <F9> :call Browser("")<CR>
    autocmd FileType sh map <F9> :sh "%:p"<CR>

    noremap <F10> :set spell!<CR>
    inoremap <F10> <Esc> :set spell!<CR>
    vnoremap <F10> <Esc> :set spell!<CR>

    " simple matching pairs easily, with Tab
    map <Tab> %

    " Permet de placer au milieu de l'écran l'occurence de la recherche
    nnoremap n nzzzv
    nnoremap N Nzzzv

    " Emacs transpose-words
    nnoremap <silent> gw "_yiw:s/\(\%#\w\+\)\(\W\+\)\(\w\+\)/\3\2\1/<CR><c-o><c-l>

    if !empty(system("setxkbmap -print|grep bepo"))
        source ~/.vim/bepo.vim
    endif

    " Disable arrows. hjkl are a lot faster.
    nnoremap <Up> <nop>
    nnoremap <Down> <nop>
    nnoremap <Left> <nop>
    nnoremap <Right> <nop>

" }}}

" Plugins {{{
    " Chargement des reffons en fonction du type
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
    " gitv {{{
        let g:Gitv_OpenHorizontal = 1
        let g:Gitv_WrapLines = 0
    " }}}
    " LanguageTool {{{
        let g:languagetool_jar = substitute(system("find ~/.config/libreoffice/3/user/extensions -name LanguageTool.jar"), "\n", "", "g")
    " }}}
    " mail {{{
        autocmd FileType mail :source ~/.vim/mail.vim
        autocmd FileType mkd :source ~/.vim/mail.vim
    " }}}
    " nerdtree {{{
        nnoremap <silent> <F3> :NERDTreeToggle<CR>
        let NERDTreeQuitOnOpen=1
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
        let g:Powerline_symbols = 'unicode'
    " }}}
    " Seeks {{{
        let g:seeks_node = 'http://seeks.homecomputing.fr'
        let g:seeks_max_results = -1
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
        autocmd BufEnter *Controller.php nmap <buffer><leader>v :SfJumpToView<CR>

        set wildignore=data/**,app/cache/**,web/bundles/**
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
    " xdebug {{{
        let g:debuggerMapDefaultKeys = 0

        map <leader><F1> :python debugger_resize()<CR>
        map <leader><F2> :python debugger_command('step_into')<CR>
        map <leader><F3> :python debugger_command('step_over')<CR>
        map <leader><F4> :python debugger_command('step_out')<CR>

        map <leader><F5> :python debugger_run()<CR>
        map <leader><F6> :python debugger_quit()<CR>

        map <leader><F7> :python debugger_command('step_into')<CR>
        map <leader><F8> :python debugger_command('step_over')<CR>
        map <leader><F9> :python debugger_command('step_out')<CR>

        map <leader><F11> :python debugger_context()<CR>
        map <leader><F12> :python debugger_property()<CR>
    " }}}
    " dwm {{{
        let g:dwm_map_keys = 0

        map <C-N> :call DWM_New()<CR>
        map <C-C> :call DWM_Close()<CR>
        map <C-Space> :call DWM_Focus()<CR>
        map <C-@> :call DWM_Focus()<CR>
        " In preparation of mode system
        map <C-M> :call DWM_Full()<CR>
        map <C-t> <C-W>w
        map <C-s> <C-W>W
    "}}}
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
        autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
        autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
        autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
        autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
        autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

        " Enable heavy omni completion.
        if !exists('g:neocomplcache_omni_patterns')
          let g:neocomplcache_omni_patterns = {}
        endif
        let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
        "autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
        let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
        let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
        let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'
    " }}}
    " easytags {{{
        set tags=./tags
        let g:easytags_dynamic_files = 2
        let g:easytags_include_members = 1
    " }}}
    " syntastic {{{
        let g:syntastic_auto_loc_list = 2
        let g:syntastic_auto_jump = 1
        let g:syntastic_phpcs_disable = 1
        let g:syntastic_error_symbol = '✗'
        let g:syntastic_warning_symbol = '⚠'
    " }}}
" }}}

let obs_vim=vimfiles . "/obs.vim"
if filereadable(obs_vim)
    exec "source " . obs_vim
endif
