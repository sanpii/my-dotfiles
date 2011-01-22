" README {{{
"
" Greffons
"     http://www.vim.org/scripts/script.php?script_id=1658
"     http://www.vim.org/scripts/script.php?script_id=273
"     http://www.vim.org/scripts/script.php?script_id=1302
"     http://www.vim.org/scripts/script.php?script_id=2204
"     http://www.vim.org/scripts/script.php?script_id=2390
"
" http://vim.wikia.com/wiki/PHP_manual_in_Vim_help_format
" http://live.gnome.org/Vala/Vim
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Général {{{

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
endif

if &term =~ '^\(xterm\|screen\)$' && $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

" Désactive la compatibilité avec VI (doit être la première ligne!)
set nocompatible

" Encodage en UTF-8
set encoding=utf-8

" Accélère le rendu graphique dans les terminaux véloces
set ttyfast

" Support du type de format unix uniquement
set fileformats=unix,dos,mac

" Détection du type de fichier
filetype on

" Afficher une liste lors de complétion de commandes/fichiers
"set wildmenu                           "affiche le menu
"set wildmode=list:longest,list:full    "affiche toutes les possibilités

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

" Format de la ligne de statut
set statusline=%<%F\ %m%r\ %14.(%y[%{&encoding}][%{&ff}]%)%=%-14.(%l,%v%)\ %P

" Afficher la correspondance des parenthèses
set showmatch

" Replie de code à l'aide de marqueurs
set foldmethod=marker

" Sauvegarde des marqueurs
let view_dir=vimfiles . "/view"
if isdirectory(view_dir)
    exec "set viewdir=" . view_dir
    au BufWinLeave *? mkview
    au BufWinEnter *? silent loadview
endif
unlet view_dir

" Cacher les tampons quand ils sont abandonnés
set hidden

" Nombre de commandes maximale dans l'historique
set history=100

" Récupérer la position du curseur entre 2 ouvertures de fichiers
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif

" Afficher les espaces superflus et les tabulations
:hi ExtraWhitespace ctermbg=darkred guibg=darkred
:match ExtraWhitespace /\s\+$\|\t/

" Suppression automatique des espaces superflu
autocmd BufWritePre * :%s/\s\+$//e

" Se place dans le répertoire du fichier éditer
autocmd BufEnter * execute "chdir ".escape(expand("%:p:h"), ' ')

" Changement automatique de répertoire (exécution après compil)
set autochdir

" Permettre l'utilisation de la touche backspace dans tous les cas
set backspace=2

" Démarrer dans le répertoire Code
":chdir $HOME/code/
"set browsedir=current

" Affiche la limite de 80 caractères
au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)

" Omni-completion
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete

set completeopt=longest,menuone

let php_sql_query=1
let php_htmlInStrings=1

" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Apparence {{{

" Set font according to system
if MySys() == "mac"
    set gfn=Menlo:h14
    set shell=/bin/bash
elseif MySys() == "win32"
    set gfn=Consolas:h11
    set shell=c:\Programs\msys\1.0\bin\bash
elseif MySys() == "unix"
    set gfn=Monospace\ 10
    set shell=/bin/bash
endif

" Coloration syntaxique
syntax on

" Utiliser des couleurs correctes sur un fond sombre
set background=dark

" Afficher une ligne à la position du curseur
set cursorline
:hi CursorLine cterm=bold gui=bold

" Thème de couleur pour Vim
"colorscheme devbox
"colorscheme vo_dark
colorscheme desert

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

" Coller dans Vim sans tabulations incrémentées
set paste

" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Correction orthographique {{{

" version Nemolivier
set nospell spelllang=fr
" automatique pour les fichiers .tex
augroup filetypedetect
au BufNewFile,BufRead *.tex setlocal spell spelllang=fr
augroup END
" F10 active/désactive la correction orthographique
function! ToggleSpell()
  if &spell
     set nospell
  else
     set spell
  end
endfunction
noremap <F10> :call ToggleSpell()<cr>
inoremap <F10> <Esc> :call ToggleSpell()<cr>
vnoremap <F10> <Esc> :call ToggleSpell()<cr>

" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Recherches {{{

" Utiliser la recherche incrémentielle
set incsearch

" Ne pas surligner les résultats de recherche
"set nohlsearch

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

" Descendre la ligne courante d'une ligne
"map <C-S-Down> dd p

" Remonter la ligne courante d'une ligne
"map <C-S-Up> dd kk 0 P

" Dupliquer la ligne courante via Ctrl-d (/!\ désactive le scroll)
"map <C-d> yy p

" Ouverture de l'explorateur de fichiers avec la touche F3
"map <F3> :e .<cr>
"map <F3> :browse e<cr>

" Gestion des onglets
"map <F4> :tabnew<cr>
map <C-A-PageDown> :tabnext<cr>
map <C-A-PageUp> :tabprevious<cr>

" Exécuter le fichier
au BufEnter *.py map <F6> :!python "%"<cr>
au BufEnter *.c map <F6> :!gcc -o "%:r" % && ./%:r<cr>
au BufEnter *.vala map <F6> :!vala "%"<cr>
au BufEnter *.gs map <F6> :!vala "%"<cr>
au BufEnter *.tex map <F6> :!pdflatex "%" && evince "%:r.pdf"<cr>
au BufEnter *.php map <F6> :!php "%"<cr>

" Exécuter le fichier actuel dans le navigateur via F7
function! Browser(uri)
  let uri=a:uri

  if uri == ""
    let uri=expand("%:p")
  endif
  exec ":silent !x-www-browser ".uri
endfunction
map <F7> :call Browser("")<cr>
au BufEnter *.php map <F7> :call Browser(expand("%:p:s?d:\\\\workspace?http://localhost?:gs?\\?/?"))<cr>

" Ouvrir l'URL sous le curseur dans un navigateur
map gu :call Browser(expand('<cWORD>'))<cr>

" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins {{{

" Chargement des reffons en fonction du type
filetype plugin indent on

" Configuration du plugin Vimoutliner
au BufEnter TODO setfiletype vo_base

" taglist
nnoremap <silent> <F8> :TlistToggle<CR>
let Tlist_Compact_Format=1
let Tlist_Exit_OnlyWindow=1
let Tlist_GainFocus_On_ToggleOpen=1
let Tlist_Process_File_Always=1
let Tlist_Show_One_File=1
let Tlist_Use_Right_Window=1
let Tlist_Enable_Fold_Column=0

" nerdtree
nnoremap <silent> <F3> :NERDTreeToggle<CR>
let NERDTreeQuitOnOpen=1

" vala
autocmd BufRead *.vala set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
autocmd BufRead *.vapi set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
au BufRead,BufNewFile *.vala            setfiletype vala
au BufRead,BufNewFile *.vapi            setfiletype vala

"let vala_ignore_valadoc=1 " Disable valadoc syntax highlight
let vala_comment_strings=1 " Enable comment strings
let vala_space_errors=1 " Highlight space errors
"let vala_no_trail_space_error=1 " Disable trailing space errors
"let vala_no_tab_space_error=1 " Disable space-tab-space errors
"let vala_minlines = 120 " Minimum lines used for comment syncing (default 50)

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
endif

" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

