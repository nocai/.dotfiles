" ===
" === Cursor Movement for colmark
" ===
"     ^
"     n
" < h   i >
"     e
"     v

" nN => jJ {{{
noremap n          j
" g<Down>
noremap gn         gj
noremap N          J

noremap <C-n>      <C-j>
noremap <C-w>n     <C-w>j
noremap <C-w><C-n> <C-w><C-j>
" }}}

" jJ => eE {{{
noremap j          e
noremap J          E
" Backward to the end of word
noremap gj         ge
noremap gJ         gE

noremap <C-j>      <C-e>
noremap <C-w>j	   <C-w>e
noremap <C-w><C-j> <C-w><C-e>
" }}}

" eE => kK {{{
noremap e          k
" g<Up>
noremap ge         gk
noremap E          K
noremap <C-e>      <C-k>
noremap <C-w>e     <C-w>k
noremap <C-w><C-e> <C-w><C-k>
" }}}

" kK => nN {{{
noremap k          n
noremap K          N
noremap <C-k>      <C-n>
noremap <C-w>k     <C-w>n
noremap <C-w><C-k> <C-w><C-n>
" }}}

" iL => lL {{{
noremap i          l
noremap I          L
noremap <C-i>      <C-l>
noremap <C-w>i     <C-w>l
noremap <C-w><C-i> <C-w><C-l>
" }}}

" lL => iI {{{
noremap l          i
noremap L          I
noremap <C-l>      <C-i>
noremap <C-w>l     <C-w>i
noremap <C-w><C-l> <C-w><C-i>
" }}}
