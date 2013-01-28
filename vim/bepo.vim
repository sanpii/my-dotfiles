" {W} -> [É]
noremap é w
noremap É W
noremap aé aw
noremap aÉ aW
map w <C-w>
map W <C-w><C-w>

" [HJKL] -> {CTSR}
noremap c h
noremap r l
noremap t j
noremap s k
noremap C H
noremap R L
noremap T J
noremap S K
noremap zs zj
noremap zt zk

" {HJKL} <- [CTSR]
noremap j t
noremap J T
noremap l c
noremap L C
noremap h r
noremap H R
noremap k s
noremap K S
noremap ]k ]s
noremap [k [s

" Window mapping
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
noremap gs gk
noremap gt gj
noremap gb gT
noremap gé gt

" <> en direct
noremap « <
noremap » >

noremap è ^
noremap È 0

noremap C ^
noremap R g_
