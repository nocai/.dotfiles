" let mapleader=" "

" ===
" === Cursor Movement
" ===
" New cursor movement (the default arrow keys are used for resizing windows)
"     ^
"     n
" < h   i >
"     e
"     v
noremap <silent> n j
noremap <silent> N J
noremap <silent> <C-w>n <C-w>j
noremap <silent> <C-n> 5j
noremap <silent> e k
noremap <silent> E K
noremap <silent> <C-w>e <C-w>k
noremap <silent> <C-e> 5k
noremap <silent> i l
noremap <silent> I L
noremap <silent> <C-w>i <C-w>l

noremap <silent> k n
noremap <silent> K N

noremap <silent> j e
noremap <silent> J E

noremap <silent> u i
noremap <silent> U I

noremap <silent> l u
noremap <silent> <C-l> <C-u>
noremap <silent> L U

" Resize splits with arrow keys
noremap <up> :res +5<CR>
noremap <down> :res -5<CR>
noremap <left> :vertical resize-5<CR>
noremap <right> :vertical resize+5<CR>


if has("termguicolors")
    " fix bug for vim
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif

let autosave=5

set ic
set nu
set rnu
set hidden
set cursorline
set expandtab
set autoindent
set nobackup
set nowritebackup
set noswapfile
"set splitbelow
"set splitright
set hlsearch 
set incsearch
set smartcase 
set ignorecase
set showcmd
set noshowmode

set ts=4
set sw=4
set updatetime=300
set shortmess+=c
set scrolloff=5
set signcolumn=yes
set clipboard=unnamed
set timeoutlen=1000 ttimeoutlen=0

" filetype
filetype on
filetype indent on
filetype plugin on

syntax on


call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-fugitive'
autocmd BufReadPost fugitive://* set bufhidden=delete
Plug 'airblade/vim-gitgutter'
Plug 'morhetz/gruvbox'
Plug 'jiangmiao/auto-pairs'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-surround'
Plug 'preservim/nerdtree'
let NERDTreeMapOpenExpl = ""
let NERDTreeMinimalUI = 1
let NERDTreeQuitOnOpen = 3
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif " 只有一个buffer关闭时，关闭nerdtree窗口
autocmd BufEnter * if bufname('#') =~# "^NERD_tree_" && winnr('$') > 1 | b# | endif " If more than one window and previous buffer was NERDTree, go back to it.
nnoremap <silent> tt :NERDTreeToggle<CR>
Plug 'preservim/nerdcommenter'
let g:NERDSpaceDelims = 1 " Add spaces after comment delimiters by default
map <C-_> <Plug>NERDCommenterToggle 
Plug 'vim-airline/vim-airline'
let g:airline_powerline_fonts = 1  " 支持 powerline 字体
let g:airline#extensions#tabline#enabled = 1
" If installed using Homebrew
" Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
let g:fzf_preview_window = 'right:60%' " Always enable preview window on the right with 60% width
nnoremap <silent> <Leader>f :Files<CR>
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <Leader>rg :Rg<CR>
nnoremap <silent> <Leader>ag :Ag<CR>

" Plug 'fatih/vim-go'
" " use golang language server
" let g:go_def_mode='gopls'
" let g:go_info_mode='gopls'
" " Highlight more info
" let g:go_highlight_build_constraints = 1
" let g:go_highlight_extra_types = 1
" let g:go_highlight_fields = 1
" let g:go_highlight_functions = 1
" let g:go_highlight_methods = 1
" let g:go_highlight_operators = 1
" let g:go_highlight_structs = 1
" let g:go_highlight_types = 1
" " highlight same variable in view
" let g:go_auto_sameids = 1
" " show type info in statusbar
" let g:go_auto_type_info = 1
" " disable gd mapping of vim-go
" let g:go_def_mapping_enabled = 0

" Plug 'govim/govim'

Plug 'janko/vim-test'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
"set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <expr><C-e> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if has('patch8.1.1068')
  " Use `complete_info` if your (Neo)Vim version supports it.
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Symbol renaming.
nmap <silent> rn <Plug>(coc-rename)

" Use dc to show documentation in preview window.
nnoremap <silent> dc :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')


" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap uf <Plug>(coc-funcobj-i) 
xmap af <Plug>(coc-funcobj-a)
omap uf <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" coc-go
autocmd BufWritePre *.go :call CocAction('format')
autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')

Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
Plug 'dhruvasagar/vim-table-mode'


call plug#end()

colorscheme gruvbox
"colorscheme NeoSolarized

"set background=dark
"colorscheme solarized
