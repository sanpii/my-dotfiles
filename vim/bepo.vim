" {W} -> [É]
" ——————————
" On remappe W sur É :
noremap é w
noremap É W
" Corollaire, pour effacer/remplacer un mot quand on n’est pas au début (daé / laé).
" (attention, cela diminue la réactivité du {A}…)
noremap aé aw
noremap aÉ aW
" Pour faciliter les manipulations de fenêtres, on utilise {W} comme un Ctrl+W :
map w <C-w>
map W <C-w><C-w>

" [HJKL] -> {CTSR}
" ————————————————
" {cr} = « gauche / droite »
noremap c h
noremap r l
" {ts} = « haut / bas »
noremap t j
noremap s k
" {CR} = « haut / bas de l'écran »
noremap C H
noremap R L
" {TS} = « joindre / aide »
noremap T J
noremap S K
" Corollaire : repli suivant / précédent
noremap zs zj
noremap zt zk

" {HJKL} <- [CTSR]
" ————————————————
" {J} = « Jusqu'à »            (j = suivant, J = précédant)
noremap j t
noremap J T
" {L} = « Change »             (l = attend un mvt, L = jusqu'à la fin de ligne)
noremap l c
noremap L C
" {H} = « Remplace »           (h = un caractère slt, H = reste en « Remplace »)
noremap h r
noremap H R
" {K} = « Substitue »          (k = caractère, K = ligne)
noremap k s
noremap K S
" Corollaire : correction orthographique
noremap ]k ]s
noremap [k [s

" Window mapping
" ————————————————
noremap <C-W>c <C-W>h
noremap <C-W>r <C-W>l
noremap <C-W>t <C-W>j
noremap <C-W>s <C-W>k
noremap <C-W>C <C-W>H
noremap <C-W>R <C-W>L
noremap <C-W>T <C-W>J
noremap <C-W>S <C-W>K

noremap <C-W>j <C-W>t
noremap <C-W>J <C-W>T
noremap <C-W>l <C-W>c
noremap <C-W>L <C-W>C
noremap <C-W>h <C-W>r
noremap <C-W>H <C-W>R
noremap <C-W>k <C-W>s
noremap <C-W>K <C-W>S

" Désambiguation de {g}
" —————————————————————
" ligne écran précédente / suivante (à l'intérieur d'une phrase)
noremap gs gk
noremap gt gj
" onglet précédant / suivant
noremap gb gT
noremap gé gt
" optionnel : {gB} / {gÉ} pour aller au premier / dernier onglet
noremap gB :exe "silent! tabfirst"<CR>
noremap gÉ :exe "silent! tablast"<CR>
" optionnel : {g"} pour aller au début de la ligne écran
noremap g" g0

" <> en direct
" ————————————
noremap « <
noremap » >

noremap è ^
noremap È 0

noremap C ^
noremap R g_

let g:ctrlp_prompt_mappings = {
    \ 'PrtSelectMove("j")':   ['<c-t>'],
    \ 'PrtSelectMove("k")':   ['<c-s>'],
    \ 'PrtHistory(-1)':       ['<c-n>'],
    \ 'PrtHistory(1)':        ['<c-p>'],
    \ 'AcceptSelection("t")': ['<Enter>'],
    \ 'AcceptSelection("h")': ['<c-x>', '<c-cr>'],
    \ }
