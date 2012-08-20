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

    " Rebuild tag index
    nnoremap <silent> <F7> :silent !ctags -h ".php" --PHP-kinds=+cf --recurse --exclude=".git_externals/*" --exclude="*/cache/*" --exclude="*/logs/*" --exclude="*/data/*" --exclude="\.git" --exclude="\.svn" --languages=PHP &<CR>

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
    set tags=/home/mco/tags,./tags,../tags,../../tags

    " Chargement des reffons en fonction du type
    filetype plugin indent on

    " cfi {{{
        let g:cfi_php_show_params = 1
    " }}}
    " ctrlp {{{
        imap <C-S-P> <Esc> :CtrlP %:h<CR>
        map <C-S-P> :CtrlP %:h<CR>
        let g:ctrlp_clear_cache_on_exit = 0
        let g:ctrlp_follow_symlinks = 0
        let g:ctrlp_default_input = 1
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
    " suckless {{{
        let g:SucklessDefaultMapping=0

        " keyboard mappings, Tab management {{{
            " <Esc>[1..0]>: select Tab [1..10] {{{
                noremap <silent>  <Esc>1 :tabn  1<CR>
                noremap <silent>  <Esc>2 :tabn  2<CR>
                noremap <silent>  <Esc>3 :tabn  3<CR>
                noremap <silent>  <Esc>4 :tabn  4<CR>
                noremap <silent>  <Esc>5 :tabn  5<CR>
                noremap <silent>  <Esc>6 :tabn  6<CR>
                noremap <silent>  <Esc>7 :tabn  7<CR>
                noremap <silent>  <Esc>8 :tabn  8<CR>
                noremap <silent>  <Esc>9 :tabn  9<CR>
                noremap <silent>  <Esc>0 :tabn 10<CR>
            "}}}
            " <Leader>t[1..0]: move current window to Tab [1..10] {{{
                noremap <silent> <Leader>t1 :call MoveToTab( 1,0)<CR>
                noremap <silent> <Leader>t2 :call MoveToTab( 2,0)<CR>
                noremap <silent> <Leader>t3 :call MoveToTab( 3,0)<CR>
                noremap <silent> <Leader>t4 :call MoveToTab( 4,0)<CR>
                noremap <silent> <Leader>t5 :call MoveToTab( 5,0)<CR>
                noremap <silent> <Leader>t6 :call MoveToTab( 6,0)<CR>
                noremap <silent> <Leader>t7 :call MoveToTab( 7,0)<CR>
                noremap <silent> <Leader>t8 :call MoveToTab( 8,0)<CR>
                noremap <silent> <Leader>t9 :call MoveToTab( 9,0)<CR>
                noremap <silent> <Leader>t0 :call MoveToTab(10,0)<CR>
            "}}}
            " <Leader>T[1..0]: copy current window to Tab [1..10] {{{
                noremap <silent> <Leader>T1 :call MoveToTab( 1,1)<CR>
                noremap <silent> <Leader>T2 :call MoveToTab( 2,1)<CR>
                noremap <silent> <Leader>T3 :call MoveToTab( 3,1)<CR>
                noremap <silent> <Leader>T4 :call MoveToTab( 4,1)<CR>
                noremap <silent> <Leader>T5 :call MoveToTab( 5,1)<CR>
                noremap <silent> <Leader>T6 :call MoveToTab( 6,1)<CR>
                noremap <silent> <Leader>T7 :call MoveToTab( 7,1)<CR>
                noremap <silent> <Leader>T8 :call MoveToTab( 8,1)<CR>
                noremap <silent> <Leader>T9 :call MoveToTab( 9,1)<CR>
                noremap <silent> <Leader>T0 :call MoveToTab(10,1)<CR>
            "}}}
        "}}}
        " keyboard mappings, Window management {{{
            " Alt+[kdf]: Window mode selection {{{
                noremap <silent> <Esc>k :call SetTilingMode("S")<CR>
                noremap <silent> <Esc>d :call SetTilingMode("D")<CR>
                noremap <silent> <Esc>f :call SetTilingMode("F")<CR>
            "}}}
            " Altr[ctsr]: select window {{{
                noremap <silent> <Esc>c :call WindowCmd("h")<CR>
                noremap <silent> <Esc>t :call WindowCmd("j")<CR>
                noremap <silent> <Esc>s :call WindowCmd("k")<CR>
                noremap <silent> <Esc>r :call WindowCmd("l")<CR>
            "}}}
            " Alt+[CTSR]: move current window {{{
                noremap <silent> <Esc>C :call WindowMove("h")<CR>
                noremap <silent> <Esc>T :call WindowMove("j")<CR>
                noremap <silent> <Esc>S :call WindowMove("k")<CR>
                noremap <silent> <Esc>R :call WindowMove("l")<CR>
            "}}}
            " Ctrl+Alt+[ctsr]: resize current window {{{
                noremap <silent> <Esc><C-c> :call WindowResize("h")<CR>
                noremap <silent> <Esc><C-t> :call WindowResize("j")<CR>
                noremap <silent> <Esc><C-s> :call WindowResize("k")<CR>
                noremap <silent> <Esc><C-r> :call WindowResize("l")<CR>
            "}}}
        "}}}

        " other mappings {{{
            " Alt+[oO]: new horizontal/vertical window
            noremap <silent> <Esc>o :call WindowCmd("n")<CR>
            noremap <silent> <S-A-o> :call WindowCmd("n")<CR>:call WindowMove("l")<CR>
            " Alt+[xX]: collapse/close current window
            noremap <silent> <Esc>x :call WindowCollapse()<CR>
            noremap <silent> <Esc><S-x> :call WindowCmd("c")<CR>
        "}}}
    "}}}
" }}}

let obs_vim=vimfiles . "/obs.vim"
if filereadable(obs_vim)
    exec "source " . obs_vim
endif
