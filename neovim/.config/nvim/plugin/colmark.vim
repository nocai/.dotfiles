" ===
" === Cursor Movement for colmark
" ===
"     ^
"     n
" < h   i >
"     e
"     v

" nN => jJ {{{
nnoremap n          j
xnoremap n          j
onoremap n          j
nnoremap N          J
xnoremap N          J
onoremap N          J
" g<Down>
nnoremap gn         gj
nnoremap <C-n>      <C-j>
nnoremap <C-w>n     <C-w>j
nnoremap <C-w><C-n> <C-w><C-j>
" }}}

" jJ => eE {{{
nnoremap j          e
xnoremap j          e
onoremap j          e
nnoremap J          E
xnoremap J          E
onoremap J          E
" Backward to the end of word
nnoremap gj         ge
nnoremap gJ         gE
nnoremap <C-j>      <C-e>
nnoremap <C-w>j	   <C-w>e
nnoremap <C-w><C-j> <C-w><C-e>
" }}}

" eE => kK {{{
nnoremap e          k
xnoremap e          k
onoremap e          k
nnoremap E          K
xnoremap E          K
onoremap E          K
" g<Up>
nnoremap ge         gk
nnoremap <C-e>      <C-k>
nnoremap <C-w>e     <C-w>k
nnoremap <C-w><C-e> <C-w><C-k>
" }}}

" kK => nN {{{
nnoremap k          n
xnoremap k          n
onoremap k          n
nnoremap K          N
xnoremap K          N
onoremap K          N
nnoremap <C-k>      <C-n>
nnoremap <C-w>k     <C-w>n
nnoremap <C-w><C-k> <C-w><C-n>
" }}}

" iL => lL {{{
nnoremap i          l
xnoremap i          l
onoremap i          l
nnoremap I          L
xnoremap I          L
onoremap I          L
nnoremap <C-i>      <C-l>
nnoremap <C-w>i     <C-w>l
nnoremap <C-w><C-i> <C-w><C-l>
" }}}

" lL => iI {{{
nnoremap l          i
xnoremap l          i
onoremap l          i
nnoremap L          I
xnoremap L          I
onoremap L          I
nnoremap <C-l>      <C-i>
nnoremap <C-w>l     <C-w>i
nnoremap <C-w><C-l> <C-w><C-i>
" }}}
