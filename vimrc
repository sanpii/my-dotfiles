" README {{{
"
" Greffons
"     - The NERD tree : http://www.vim.org/scripts/script.php?script_id=1658
"     - taglist : http://www.vim.org/scripts/script.php?script_id=273
"     - maximize : http://www.vim.org/scripts/script.php?script_id=1302
"     - TwitVim  : http://www.vim.org/scripts/script.php?script_id=2204
"     - PHP debugger : http://www.vim.org/scripts/script.php?script_id=1152
"     - vimwiki : http://www.vim.org/scripts/script.php?script_id=2226
"     - matchit : http://www.vim.org/scripts/script.php?script_id=39
"     - CSApprox : http://www.vim.org/scripts/script.php?script_id=2390
"     - Conque Shell : http://www.vim.org/scripts/script.php?script_id=2771
"
" http://vim.wikia.com/wiki/PHP_manual_in_Vim_help_format
" http://live.gnome.org/Vala/Vim
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
    let g:loaded_maximize=1
endif

if &term =~ '^\(xterm\|screen\)$' && $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

" Pour utiliser vim comme lecteur de page man
let $PAGER=''

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

" Ne pas couper les lignes trop longues
set nowrap

" Suppression automatique des espaces superflu
autocmd BufWritePre * :%s/\s\+$//e

" Se place dans le répertoire du fichier éditer
"autocmd BufEnter * execute "chdir ".escape(expand("%:p:h"), ' ')

" Changement automatique de répertoire (exécution après compil)
set autochdir

" Permettre l'utilisation de la touche backspace dans tous les cas
set backspace=2

" Démarrer dans le répertoire Code
":chdir $HOME/code/
"set browsedir=current

" Affiche la limite de 80 caractères
"autocmd BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
set colorcolumn=81

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

" Utiliser des couleurs correctes sur un fond sombre
set background=dark

" Coloration syntaxique
syntax on

" Thème de couleur pour Vim
"colorscheme devbox
"colorscheme vo_dark
colorscheme desert

" Set font according to system
if MySys() == "mac"
    set gfn=Menlo:h14
    set shell=/bin/bash
elseif MySys() == "win32"
    set gfn=Consolas:h11
    set shell=c:\Programs\msys\1.0\bin\sh
elseif MySys() == "unix"
    set gfn=Monospace\ 10
    set shell=/bin/bash
endif

" Afficher les caractères spéciaux
"set list listchars=tab:»·,trail:·,precedes:…,extends:…,nbsp:‗,eol:¶
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

" Gestion des fenêtres
map <S-Up> :wincmd k<cr>
map <S-Down> :wincmd j<cr>
map <S-Left> :wincmd h<cr>
map <S-Right> :wincmd l<cr>

map <C-S-Right> :wincmd H<cr>
map <C-S-Left> :windo wincmd K<cr>

" Exécuter le fichier
au BufEnter *.py map <F9> :!python "%"<cr>
au BufEnter *.c map <F9> :!gcc -o "%:r" % && ./%:r<cr>
au BufEnter *.vala map <F9> :!valac "%" && ./%:r<cr>
au BufEnter *.gs map <F9> :!valac "%" && ./%:r<cr>
au BufEnter *.tex map <F9> :!pdflatex "%" && evince "%:r.pdf"<cr>
au BufEnter *.php map <F9> :!php "%"<cr>

" Exécuter le fichier actuel dans le navigateur via F7
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
map <F7> :call Browser("")<cr>
au BufEnter *.php map <F7> :call Browser(expand("%:p:s?d:\\\\workspace?http://localhost?:gs?\\?/?"))<cr>

" Ouvrir l'URL sous le curseur dans un navigateur
map gu :call Browser(expand('<cWORD>'))<cr>

" Move content up
nmap <M-S-Up> :m .-2<Enter>
nmap <M-S-k> <M-S-Up>
vmap <M-S-Up> :m .-2<Enter>gv
vmap <M-S-k> <M-S-Up>

" Move content down
nmap <M-S-Down> :m .+1<Enter>
nmap <M-S-j> <M-S-Down>
vmap <M-S-Down> :m '>+1<Enter>gv
vmap <M-S-j> <M-S-Down>

" Copy content up
nmap <C-S-Up> :co .-1<Enter>
nmap <C-S-k> <C-S-Up>
vmap <C-S-Up> :co '><Enter>gv
vmap <C-S-k> <C-S-Up>

" Copy content down
nmap <C-S-Down> :co .<Enter>
nmap <C-S-j> <C-S-Down>
vmap <C-S-Down> :co .-1<Enter>gv
vmap <C-S-j> <C-S-Down>

" Shifts content left
nmap <M-S-Left> <<
nmap <M-S-h> <M-S-Left>
vmap <M-S-Right> <gv
vmap <M-S-h> <M-S-Left>

" Shifts content right
nmap <M-S-Right> >>
nmap <M-S-l> <M-S-Right>
vmap <M-S-Right> >gv
vmap <M-S-l> <M-S-Right>


" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins {{{

" Chargement des reffons en fonction du type
filetype plugin indent on

" Configuration du plugin Vimoutliner
au BufEnter TODO setfiletype vo_base

" taglist
nnoremap <silent> <F8> :TlistToggle<cr>
let Tlist_Compact_Format=1
let Tlist_Exit_OnlyWindow=1
let Tlist_GainFocus_On_ToggleOpen=1
let Tlist_Process_File_Always=1
let Tlist_Show_One_File=1
let Tlist_Enable_Fold_Column=0
let Tlist_Short_Type="name"
let Tlist_Use_Right_Window=1

let Tlist_php_settings='php;c:class;d:constant;f:function'

" nerdtree
nnoremap <silent> <F3> :NERDTreeToggle<cr>
let NERDTreeQuitOnOpen=1

" vimwiki
let Tlist_vimwiki_settings='wiki;h:Headers'

" conque
nnoremap <silent> <F2> :ConqueTermSplit bash<cr>
autocmd FileType conque_term :set bufhidden=delete
autocmd FileType conque_term :set list listchars=

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

