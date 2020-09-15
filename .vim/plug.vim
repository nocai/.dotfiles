" if filereadable(expand("~/.dotfiles/.vim/env.vim"))
" 	source ~/.dotfiles/.vim/env.vim
" endif

" Plug 'rhysd/accelerated-jk', {'on':['<Plug>(accelerated_jk_gj)' , '<Plug>(accelerated_jk_gk)']}
" nmap n <Plug>(accelerated_jk_gj)
" nmap e <Plug>(accelerated_jk_gk)

" Plug 'ianding1/leetcode.vim'
" let g:leetcode_browser='chrome'
" let g:leetcode_china=1
" let g:leetcode_solution_filetype='golang'
" Plug 'tpope/vim-repeat'

Plug 'tpope/vim-surround'

Plug 'voldikss/vim-floaterm', { 'on': 'FloatermNew' }

Plug 'jiangmiao/auto-pairs'
" let g:AutoPairsFlyMode = 1

" Plug 'luochen1990/rainbow'
" let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle

" Plug 'itchyny/vim-cursorword'

" Plug 'easymotion/vim-easymotion'

" Plug 'vim-airline/vim-airline'
" let g:airline_powerline_fonts = 1  " 支持 powerline 字体
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#coc#enabled = 1
" let g:airline#extensions#hunks#coc_git = 1

" Plug 'hardcoreplayers/spaceline.vim'
" let g:spaceline_diagnostic_errorsign = '🔥'
" let g:spaceline_diagnostic_warnsign='🔆'
" let g:spaceline_git_branch_icon = ' '
" let g:spaceline_custom_diff_icon = [' ',' ',' ']
" let g:spaceline_function_icon = '🌀 '

Plug 'edkolev/tmuxline.vim' ", {'on': ['Tmuxline', 'TmuxlineSnapshot']}
" let g:tmuxline_preset = 'lightline'
Plug 'sainnhe/sonokai'

" Plug 'maximbaz/lightline-ale'
" Plug 'albertomontesg/lightline-asyncrun'
" Plug 'rmolin88/pomodoro.vim'

Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
let g:lightline = {
    \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
    \ 'colorscheme': 'one',
    \ 'active': {
    \   'left': [ 
    \             [ 'mode', 'paste' ],
    \             [ 'fugitive' ],
    \             [ 'filename', 'cocstatus' ],
    \           ],
    \ },
    \ 'tabline': {
    \   'left': [ ['buffers'] ],
    \   'right': [ ['close'] ]
    \ },
    \ 'component': {
	\   'lineinfo': ' %3l:%-2c',
    \ },
    \ 'component_function': {
    \   'filename': 'LightlineFilename',
	\   'fugitive': 'LightlineFugitive',
	\   'cocstatus': 'StatusDiagnostic',
    \ },
    \ 'component_expand': {
    \   'buffers': 'lightline#bufferline#buffers'
    \ },
    \ 'component_type': {
    \   'buffers': 'tabsel'
    \ }
    \ }
function! LightlineFugitive()
	if exists('*FugitiveHead')
		let branch = FugitiveHead()
		return branch !=# '' ? ' '.branch : ''
	endif
	return ''
endfunction
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
	return &readonly ? '' : ''
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
    return join(msgs, 'ok') . '' . get(g:, 'coc_status', '')
endfunction

" Plug 'preservim/nerdtree', {'on': ['NERDTreeToggle', 'NERDTreeFind']}
" let NERDTreeMapOpenExpl = ""
" let NERDTreeMinimalUI = 1
" let NERDTreeQuitOnOpen = 3
" " 修改默认箭头符号
" let g:NERDTreeDirArrowExpandable = '▸'
" let g:NERDTreeDirArrowCollapsible = '▾'
" " 当打开 NERDTree 窗口时，自动显示 Bookmarks
" " let NERDTreeShowBookmarks=1
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif " 只有一个buffer关闭时，关闭nerdtree窗口
" autocmd BufEnter * if bufname('#') =~# "^NERD_tree_" && winnr('$') > 1 | b# | endif " If more than one window and previous buffer was NERDTree, go back to it.
" nnoremap <silent> tt :NERDTreeToggle<CR>
" nnoremap <silent> ff :NERDTreeFind<CR>

Plug 'kdheepak/lazygit.nvim', { 'branch': 'nvim-v0.4.3' }
let g:lazygit_floating_window_winblend = 0 " transparency of floating window
let g:lazygit_floating_window_scaling_factor = 0.9 " scaling factor for floating window
" setup mapping to call :LazyGit
nnoremap <silent> <leader>lg :LazyGit<CR>

Plug 'tpope/vim-fugitive'
autocmd BufReadPost fugitive://* set bufhidden=delete

" Plug 'airblade/vim-gitgutter'

Plug 'ryanoasis/vim-devicons'
" adding to vim-airline's tabline
let g:webdevicons_enable_airline_tabline = 1
" adding to vim-airline's statusline
let g:webdevicons_enable_airline_statusline = 1


Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" let g:fzf_preview_window = ''
let g:fzf_preview_window = 'right:60%'
nnoremap <silent> <Leader>ff :Files<CR>
nnoremap <silent> <Leader>fb :Buffers<CR>
nnoremap <silent> <Leader>frg :Rg<CR>
nnoremap <silent> <Leader>fag :Ag<CR>

" Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'dhruvasagar/vim-table-mode', { 'for': ['markdown', 'vim-plug']}

" Plug 'sheerun/vim-polyglot'
" let g:polyglot_disabled = ['go']
Plug 'morhetz/gruvbox'
Plug 'sainnhe/gruvbox-material'
Plug 'lifepillar/vim-gruvbox8'
Plug 'joshdick/onedark.vim'


Plug 'junegunn/vim-easy-align', {'on':'<Plug>(EasyAlign)'}
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'
let g:textobj_indent_no_default_key_mappings=1
xmap uu <Plug>(textobj-indent-i)
omap uu <Plug>(textobj-indent-i)
xmap uU <Plug>(textobj-indent-same-i)
omap uU <Plug>(textobj-indent-same-i)

xmap au <Plug>(textobj-indent-a)
omap au <Plug>(textobj-indent-a)
xmap aU <Plug>(textobj-indent-same-a)
omap aU <Plug>(textobj-indent-same-a)

Plug 'sgur/vim-textobj-parameter'
let g:textobj_parameter_no_default_key_mappings=1
xmap u, <Plug>(textobj-parameter-i)
omap u, <Plug>(textobj-parameter-i)
xmap a, <Plug>(textobj-parameter-a)
omap a, <Plug>(textobj-parameter-a)

" set list lcs=tab:\┊\  " 显示缩进线
" Plug 'Yggdroot/indentLine'
" let g:indentLine_char_list = ['|', '¦', '┆', '┊']
" Plug 'nathanaelkane/vim-indent-guides'

Plug 'tpope/vim-commentary'

Plug 'thinca/vim-quickrun', {'for':['c', 'h', 'cpp', 'py', 'go', 'java', 'vim', 'json', 'hs']}
let g:quickrun_config = {
\   "_" : {
\       "outputter" : "message",
\   },
\}
nmap <Leader>qr <Plug>(quickrun)

Plug 'vim-test/vim-test', {'for':['c', 'h', 'cpp', 'py', 'go', 'java', 'vim', 'json', 'hs']}
let test#strategy = "neovim"
" these "Ctrl mappings" work well when Caps Lock is mapped to Ctrl
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>

" Plug 'fatih/vim-go'
" let g:go_def_mapping_enabled = 0
" let g:go_gopls_enabled = 1
" let g:go_code_completion_enabled = 0
" let g:go_get_update = 0
" let g:go_textobj_enabled = 0
" let g:go_textobj_include_function_doc = 0
" Highlight more info
" let g:go_highlight_build_constraints = 1
" let g:go_highlight_extra_types = 1
" let g:go_highlight_fields = 1
" let g:go_highlight_functions = 1
" let g:go_highlight_methods = 1
" let g:go_highlight_operators = 1
" let g:go_highlight_structs = 1
" let g:go_highlight_types = 1

Plug 'honza/vim-snippets'

Plug 'neoclide/coc.nvim', {'branch': 'master'}

let g:coc_global_extensions =[
	\ 'coc-marketplace',
	\ 'coc-vimlsp',
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
	\ 'coc-tslint-plugin',
    \ 'coc-prettier',
	\ 'coc-diagnostic',
	\ 'coc-translator',
	\ 'coc-git',
	\ 'coc-emoji'
    \]

	" \ 'coc-tabnine'



" TextEdit might fail if hidden is not set.
set hidden

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=100

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <expr><C-e> pumvisible() ? "\<C-p>" : "\<C-e>"

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

" Use K to show documentation in preview window.
nnoremap <silent><space>k :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
" 自定义一下颜色，方便显示
autocmd ColorScheme * highlight! CocHighlightText guibg=#054c20 ctermbg=023
autocmd BufWritePre *.go silent :call CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>dg  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>cm  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>n  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>e  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
" Symbol renaming.
nmap <space>rn <Plug>(coc-rename)

nmap <space>tt :CocCommand explorer<CR>
" coc-translator
nmap <space>ts <Plug>(coc-translator-p)
" coc-yank
nnoremap <silent> <space>y :<C-u>CocList -A --normal yank<cr>

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap uf <Plug>(coc-funcobj-i)
omap uf <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap uc <Plug>(coc-classobj-i)
omap uc <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap for do codeAction of selected region
function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction
xmap <silent> <space>ca :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
nmap <silent> <space>ca :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@

let g:coc_snippet_next = '<TAB>'
let g:coc_snippet_prev = '<S-TAB>'
let g:snips_author = 'lj.liujun'

" if filereadable(expand("~/.dotfiles/.vim/lightline.vim"))
	" source ~/.dotfiles/.vim/lightline.vim
" endif


" Plug 'puremourning/vimspector', {'do': './install_gadget.py --enable-go'}
" let g:vimspector_enable_mappings = 'HUMAN'
