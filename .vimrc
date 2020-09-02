" ===
" === Cursor Movement for colmark
" ===
" New cursor movement (the default arrow keys are used for resizing windows)
"     ^
"     n
" < h   i >
"     e
"     v

" let mapleader=" "

noremap n j
noremap N J
noremap <C-w>n <C-w>j
noremap <C-n> 5j

noremap e k
noremap E K
noremap <C-w>e <C-w>k
noremap <C-e> 5k

noremap i l
noremap I L
noremap <C-w>i <C-w>l

noremap k n
noremap K N

noremap j e
noremap J E
noremap <C-j> <C-e>

noremap u i
noremap U I

noremap l u
noremap L U

" Resize splits with arrow keys
noremap <silent><up> :res +5<CR>
noremap <silent><down> :res -5<CR>
noremap <silent><left> :vertical resize-5<CR>
noremap <silent><right> :vertical resize+5<CR>

noremap <C-h> ^
noremap <C-i> $
noremap R :source $MYVIMRC<CR>

if filereadable(expand("~/.dotfiles/.vim/basic.vim"))
	source ~/.dotfiles/.vim/basic.vim
endif

call plug#begin('~/.vim/plugged')
	if filereadable(expand("~/.dotfiles/.vim/plug.vim"))
	  source ~/.dotfiles/.vim/plug.vim
	endif
call plug#end()

syntax enable

set background=dark
" colorscheme gruvbox8
colorscheme gruvbox
" colorscheme onedark
"
" 背景透明
" highlight Normal guibg=NONE ctermbg=None
