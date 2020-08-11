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
noremap n j
noremap N J
noremap <C-w>n <C-w>j
" noremap <C-n> 5j
noremap e k
noremap E K
noremap <C-w>e <C-w>k
" noremap <C-e> 5k
noremap i l
noremap I L
noremap <C-w>i <C-w>l

noremap k n
noremap K N

noremap j e
noremap J E

noremap u i
noremap U I

noremap l u
noremap L U
" Resize splits with arrow keys
noremap <silent><up> :res +5<CR>
noremap <silent><down> :res -5<CR>
noremap <silent><left> :vertical resize-5<CR>
noremap <silent><right> :vertical resize+5<CR>


" 真彩色 - 测试脚本 
" curl -s https://raw.githubusercontent.com/JohnMorales/dotfiles/master/colors/24-bit-color.sh | bash
if $COLORTERM == 'truecolor'
    " fix bug for vim
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
else
    set t_Co=256
endif

set number
set relativenumber
set cursorline
set noswapfile

"set splitbelow
"set splitright

set showcmd
set noshowmode

set hlsearch 
set incsearch
set ignorecase
set smartcase 

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent

set scrolloff=5
set shortmess+=c
set encoding=UTF-8
set timeoutlen=1000 ttimeoutlen=0

set autoread "文件在Vim之外修改过，自动重新读入"
set autowrite "设置自动保存内容"

set wildmenu
" set wildmode=longest:list,full

syntax on
" filetype
filetype on
filetype indent on
filetype plugin on

set list lcs=tab:\┊\  " 显示缩进线

set clipboard=unnamed

let g:python3_host_skip_check=1
let g:python3_host_prog = '/usr/bin/python3'

autocmd FileType go nmap <Leader>gr :!go run %<CR>
autocmd FileType go nmap <Leader>gt :!go test %<CR>

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-sensible'

" Plug 'tpope/vim-repeat'

Plug 'tpope/vim-surround'

Plug 'voldikss/vim-floaterm'

Plug 'jiangmiao/auto-pairs'

Plug 'easymotion/vim-easymotion'

" Plug 'vim-airline/vim-airline'
" let g:airline_powerline_fonts = 1  " 支持 powerline 字体
" let g:airline#extensions#tabline#enabled = 1

Plug 'itchyny/lightline.vim'
" Plug 'mengelbrecht/lightline-bufferline'
set laststatus=2
let g:lightline = {
    \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
    \ 'colorscheme': 'one',
    \ 'active': {
    \   'left': [ 
    \             [ 'mode', 'paste' ],
    \             [ 'readonly', 'fugitive' ],
    \             [ 'filename', 'cocstatus' ],
    \           ],
    \ },
    \ 'component_function': {
    \   'filename': 'LightlineFilename',
    \   'fugitive': 'FugitiveHead',
	\   'cocstatus': 'StatusDiagnostic',
    \ },
    \ }
" autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()
function! LightlineFilename()
    return (LightlineReadonly() !=# '' ? LightlineReadonly() . ' ' : '') .
    \ (&ft ==# 'vimfiler' ? vimfiler#get_status_string() :
    \  &ft ==# 'unite' ? unite#get_status_string() :
    \  &ft ==# 'vimshell' ? vimshell#get_status_string() :
    \ expand('%:t') !=# '' ? expand('%:t') : '[No Name]') .
    \ (LightlineModified() !=# '' ? ' ' . LightlineModified() : '')
endfunction
function! LightlineModified()
    return &ft =~# 'help\|vimfiler' ? '' : &modified ? '[+]' : &modifiable ? '' : '[-]'
endfunction
function! LightlineReadonly()
    return &ft !~? 'help\|vimfiler' && &readonly ? 'RO' : ''
endfunction
function! StatusDiagnostic() abort
    let info = get(b:, 'coc_diagnostic_info', {})
    if empty(info) | return '' | endif
    let msgs = []
    if get(info, 'error', 0)
        call add(msgs, 'Error: ' . info['error'])
    endif
    if get(info, 'warning', 0)
        call add(msgs, 'Warning: ' . info['warning'])
    endif
    return join(msgs, ' ') . ' ' . get(g:, 'coc_status', '')
endfunction

Plug 'preservim/nerdtree', {'on': ['NERDTreeToggle', 'NERDTreeFind']}
let NERDTreeMapOpenExpl = ""
let NERDTreeMinimalUI = 1
let NERDTreeQuitOnOpen = 3
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif " 只有一个buffer关闭时，关闭nerdtree窗口
autocmd BufEnter * if bufname('#') =~# "^NERD_tree_" && winnr('$') > 1 | b# | endif " If more than one window and previous buffer was NERDTree, go back to it.
nnoremap <silent> ff :NERDTreeToggle<CR>

Plug 'tpope/vim-fugitive'
autocmd BufReadPost fugitive://* set bufhidden=delete

Plug 'airblade/vim-gitgutter'

Plug 'ryanoasis/vim-devicons'
" adding to vim-airline's tabline
" let g:webdevicons_enable_airline_tabline = 1
" adding to vim-airline's statusline
" let g:webdevicons_enable_airline_statusline = 1

" If installed using Homebrew
" Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
let g:fzf_preview_window = 'right:60%' " Always enable preview window on the right with 60% width
nnoremap <silent> <Leader>ff :Files<CR>
nnoremap <silent> <Leader>fb :Buffers<CR>
nnoremap <silent> <Leader>frg :Rg<CR>
nnoremap <silent> <Leader>fag :Ag<CR>

Plug 'plasticboy/vim-markdown'
" Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
" let g:mkdp_echo_preview_url = 1
" Plug 'dhruvasagar/vim-table-mode'

Plug 'morhetz/gruvbox'

Plug 'tpope/vim-commentary'

Plug 'thinca/vim-quickrun'
let g:quickrun_config = {
\   "_" : {
\       "outputter" : "message",
\   },
\}
nmap <Leader>qr <Plug>(quickrun)

" Plug 'fatih/vim-go'
" let g:go_def_mapping_enabled = 0
" let g:go_gopls_enabled = 0
" let g:go_doc_popup_window = 1
" let g:go_gopls_options = ['-remote=auto']
" let g:go_fmt_command = "goimports"
" Highlight more info
" let g:go_highlight_build_constraints = 1
" let g:go_highlight_extra_types = 1
" let g:go_highlight_fields = 1
" let g:go_highlight_functions = 1
" let g:go_highlight_methods = 1
" let g:go_highlight_operators = 1
" let g:go_highlight_structs = 1
" let g:go_highlight_types = 1

Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_snippet_next = '<TAB>'
let g:coc_snippet_prev = '<S-TAB>'
let g:coc_global_extensions =[
    \ 'coc-vetur',
    \ 'coc-html',
    \ 'coc-css',
    \ 'coc-snippets',
    \ 'coc-emmet',
    \ 'coc-json',
    \ 'coc-highlight',
    \ 'coc-lists',
    \ 'coc-yaml',
    \ 'coc-gitignore',
    \ 'coc-yank',
    \ 'coc-actions',
    \ 'coc-template',
    \ 'coc-tsserver',
    \ 'coc-eslint',
    \ 'coc-prettier'
    \]


" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=100

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-y>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><C-e> pumvisible() ? "\<C-p>" : "\<C-h>"
 
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" " Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Symbol renaming.
nmap <silent> rn <Plug>(coc-rename)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
autocmd BufWritePre *.go silent :call CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" " Search workspace symbols.
" nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" " Do default action for next item.
" nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" " Do default action for previous item.
" nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" " Resume latest coc list.
" nnoremap <silent> <space>p  :<C-u>CocListResume<CR>


call plug#end()

set background=dark
colorscheme gruvbox

" 背景透明
" hi Normal ctermfg=252 ctermbg=none
" hi Normal ctermbg=none

