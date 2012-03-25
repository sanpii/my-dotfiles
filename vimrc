""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Général {{{

call pathogen#infect()

function! MySys()
    if has("win32")
        return "win32"
    elseif has("unix")
        return "unix"
    else
        return "mac"
    endif
endfunction

if MySys() == "win32"
    let vimfiles=$HOME . "/vimfiles"
elseif MySys() == "unix"
    let vimfiles=$HOME . "/.vim"
    let g:loaded_maximize=1
endif

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

" Mesure de sécurité
set nomodeline

" Désactiver la souris (molette, sélection, etc.)
set mouse=""

" Afficher des infos dans la barre de statut
set laststatus=2

" Afficher la position du curseur
set ruler

" Activer la numérotation des lignes
"set number

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

" Récupérer la position du curseur entre 2 ouvertures de fichiers
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif

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
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Apparence {{{

" Coloration syntaxique
syntax on

" Thème de couleur pour Vim
"colorscheme devbox
"colorscheme vo_dark
colorscheme desert-warm-256

" Set font according to system
if MySys() == "mac"
    set gfn=Menlo:h14
    set shell=/bin/bash
elseif MySys() == "win32"
    set gfn=Consolas:h11
    set shell=c:\Programs\msys\1.0\bin\sh
elseif MySys() == "unix"
    set gfn=Monospace\ 10
    set shell=bash
endif

" Afficher les caractères spéciaux
set list listchars=tab:»·,trail:·,precedes:…,extends:…,nbsp:‗
highlight NonText cterm=bold ctermfg=darkgrey
highlight SpecialKey cterm=bold ctermfg=darkgrey

" Afficher une ligne à la position du curseur
set cursorline
highlight CursorLine cterm=bold ctermbg=none gui=bold guibg=grey20

" Nombre de ligne minimal en dessous ou au dessus du curseur
set scrolloff=3

" Idem sur les côtés
set sidescrolloff=3

" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Correction orthographique {{{

" version Nemolivier
set nospell spelllang=fr
" automatique pour les fichiers tex
augroup filetypedetect
autocmd FileType tex setlocal spell spelllang=fr
augroup END

" F10 active/désactive la correction orthographique
function! ToggleSpell()
  if &spell
     set nospell
  else
     set spell
  end
endfunction

" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sauvegardes {{{
let backup_dir=vimfiles . "/backup"
if isdirectory(backup_dir)
    " répertoire de sauvegarde automatique
    exec "set backupdir=" . backup_dir

    " activation de la sauvegarde
    set backup
endif
unlet backup_dir

" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mappage {{{

" Help
inoremap <F1> <Esc> :exec("help ".expand("<cword>"))<CR>
nnoremap <F1> :exec("help ".expand("<cword>"))<CR>

" Rebuild tag index
nnoremap <silent> <F7> :silent !ctags -h ".php" --PHP-kinds=+cf --recurse --exclude="*/cache/*" --exclude="*/logs/*" --exclude="*/data/*" --exclude="\.git" --exclude="\.svn" --languages=PHP &<cr>:CommandTFlush<cr>

" Exécuter le fichier actuel dans le navigateur
function! Browser(uri)
    let uri=a:uri

    if uri == ""
        let uri=expand("%:p")
    endif
    if MySys() == "unix"
        exec ":silent !x-www-browser ".uri
    elseif MySys() == "win32"
        exec ":silent !firefox ".uri
    endif
    redraw!
endfunction

" Exécuter le fichier
autocmd FileType python map <F9> :!python "%"<cr>
autocmd FileType c map <F9> :!gcc -o "%:r" % && ./%:r<cr>
autocmd FileType vala map <F9> :!valac "%" && ./%:r<cr>
autocmd FileType genie map <F9> :!valac "%" && ./%:r<cr>
autocmd FileType tex map <F9> :!pdflatex "%" && see "%:r.pdf"<cr>
autocmd FileType php map <F9> :!php "%"<cr>
"autocmd FileType php map <C-F9> :call Browser(expand("%:p:s?d:\\\\workspace?http://localhost?:gs?\\?/?"))<cr>
autocmd FileType html map <F9> :call Browser("")<cr>

noremap <F10> :call ToggleSpell()<cr>
inoremap <F10> <Esc> :call ToggleSpell()<cr>
vnoremap <F10> <Esc> :call ToggleSpell()<cr>

silent! nnoremap <unique> <silent> <leader>l :CommandT<CR>

if !empty(system("setxkbmap -print|grep bepo"))
    source ~/.vim/bepo.vim
endif

" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins {{{

" Chargement des reffons en fonction du type
filetype plugin indent on

" Powerline
let g:Powerline_symbols = 'unicode'

let g:Powerline#Segments#segments = Pl#Segment#Init(
    \ Pl#Segment#Create('SPLIT'   , '__split__'),
    \ Pl#Segment#Create('TRUNCATE', '__truncate__'),
    \
    \ Pl#Segment#Create('mode_indicator'  , '%{Powerline#Functions#GetMode()}', Pl#Segment#Modes('!N')),
    \ Pl#Segment#Create('fileinfo',
        \ Pl#Segment#Create('flags.ro'    , '%{&readonly ? "$RO" : ""}'),
        \ Pl#Segment#Create('name'        , '%<%F'),
        \ Pl#Segment#Create('flags.mod'   , '%M'),
        \ Pl#Segment#Create('flags.type'  , '%H%W'),
    \ ),
    \ Pl#Segment#Create('filename'        , '%<%F'),
    \ Pl#Segment#Create('func_name'       , '%{cfi#get_func_name()}'),
    \ Pl#Segment#Create('filesize'        , '%{Powerline#Functions#GetFilesize()}', Pl#Segment#Modes('!N')),
    \ Pl#Segment#Create('pwd'             , '%{Powerline#Functions#GetPwd()}'),
    \ Pl#Segment#Create('static_str'      , '%%{"%s"}'),
    \ Pl#Segment#Create('raw'             , '%s'),
    \ Pl#Segment#Create('fileformat'      , '%{&fileformat}', Pl#Segment#Modes('!N')),
    \ Pl#Segment#Create('fileencoding'    , '%{(&fenc == "" ? &enc : &fenc)}', Pl#Segment#Modes('!N')),
    \ Pl#Segment#Create('filetype'        , '%{strlen(&ft) ? &ft : "no ft"}', Pl#Segment#Modes('!N')),
    \ Pl#Segment#Create('scrollpercent'   , '%3p%%'),
    \ Pl#Segment#Create('lineinfo',
        \ Pl#Segment#Create('line.cur'    , '$LINE %3l'),
        \ Pl#Segment#Create('line.tot'    , '$COL %-2c'),
    \ ),
    \ Pl#Segment#Create('charcode'        , '%{Powerline#Functions#GetCharCode()}', Pl#Segment#Modes('!N')),
    \ Pl#Segment#Create('currhigroup'     , '%{synIDattr(synID(line("."), col("."), 1), "name")}', Pl#Segment#Modes('!N'))
\ )

" tagbar
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

" nerdtree
nnoremap <silent> <F3> :NERDTreeToggle<cr>
let NERDTreeQuitOnOpen=1

" vimwiki
let Tlist_vimwiki_settings='wiki;h:Headers'

" vala
autocmd BufRead *.vala set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
autocmd BufRead *.vapi set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
autocmd BufRead,BufNewFile *.vala setfiletype vala
autocmd BufRead,BufNewFile *.vapi setfiletype vala

"let vala_ignore_valadoc=1 " Disable valadoc syntax highlight
let vala_comment_strings=1 " Enable comment strings
let vala_space_errors=1 " Highlight space errors
"let vala_no_trail_space_error=1 " Disable trailing space errors
"let vala_no_tab_space_error=1 " Disable space-tab-space errors
"let vala_minlines = 120 " Minimum lines used for comment syncing (default 50)

" mail
autocmd FileType mail :source ~/.vim/mail.vim
autocmd FileType mkd :source ~/.vim/mail.vim

" php-namespace
imap <buffer> <leader>u <C-O>:call PhpInsertUse()<CR>
map <buffer> <leader>u :call PhpInsertUse()<CR>

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

" }}}

" Syntastic
let g:syntastic_enable_signs=1

" cfi
let g:cfi_php_show_params=1

" piv
let g:DisableAutoPHPFolding = 1
let php_folding = 0

" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GUI {{{

if has("gui_running")
    " Désactiver la barre de menu (m), d'outils (T) et de scroll (r+l)
    set noequalalways " don't auto-resize when a window is closed
    set guioptions-=T " disable the toolbar
    set guioptions-=r " disable the right hand scrollbar
    set guioptions-=R " disable the right hand scrollbar for vsplit window
    set guioptions-=l " disable the left hand scrollbar
    set guioptions-=L " disable the left hand scrollbar for vsplit window
    set guioptions-=b " disable the bottom/horizontal scrollbar
    set guioptions-=m " disable the menu
    set guicursor+=a:blinkon0 " disable all blinking
endif

" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if filereadable("~/.vim/obs.vim")
    source ~/.vim/obs.vim
endif

