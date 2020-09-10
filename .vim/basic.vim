" Behavior {{{
" --------
set mouse=a
set clipboard=unnamed
set nobackup
set nowritebackup
set noswapfile
set undofile                            " 始终保留undo文件
set undodir=$HOME/.cache/vim/undo       " 设置undo文件的目录
set encoding=UTF-8
set timeoutlen=1000 ttimeoutlen=0
set autoread                    " Auto readfile
set nowrap                      " No wrap by default
set linebreak                   " Break long lines at 'breakat'
set breakat=\ \	;:,!?           " Long lines break chars
set nostartofline               " Cursor in same column for few commands
set whichwrap+=h,l,<,>,[,],~    " Move to following line on certain keys
set splitbelow splitright       " Splits open bottom right
set switchbuf=useopen,vsplit    " Jump to the first open window
set backspace=indent,eol,start  " Intuitive backspacing in insert mode
set diffopt=filler,iwhite       " Diff mode: show fillers, ignore whitespace
set completeopt=menu,menuone    " Always show menu, even for one item
set completeopt+=noselect,noinsert
"打开文件，光标回到上次编辑的位置
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
" }}}


" Searching {{{
" ---------
set ignorecase    " Search ignoring case
set smartcase     " Keep case when searching with *
set infercase     " Adjust case in insert completion mode
set incsearch     " Incremental search
set hlsearch      " Highlight search results
" }}}

" Tabs and Indents {{{
" ----------------
set textwidth=88    " Text width maximum chars before wrapping
set noexpandtab     " Don't expand tabs to spaces
set tabstop=4       " The number of spaces a tab is
set shiftwidth=4    " Number of spaces to use in auto(indent)
set softtabstop=-1  " Automatically keeps in sync with shiftwidth
set smarttab        " Tab insert blanks according to 'shiftwidth'
set autoindent      " Use same indenting on new lines
set smartindent     " Smart autoindenting on new lines
" syntax on
" filetype
filetype on
filetype indent on
filetype plugin on
" }}}


" Editor UI {:X{{
set number              " Show number
set relativenumber      " Show relative number
set noshowmode          " Don't show mode on bottom
set noruler             " Disable default status ruler
set scrolloff=5         " Keep at least 5 lines above/below
set list
set listchars=tab:»·,nbsp:+,trail:·,extends:→,precedes:←
set showmatch           " Jump to matching bracket
set showtabline=2       " Always show the tabs line
set laststatus=2       " Always show the status line
set showcmd             " Show command in status line
set cursorline
set colorcolumn=88

set winwidth=30         " Minimum width for active window
set winminwidth=10      " Minimum width for inactive windows
set winheight=4         " Minimum height for active window
set winminheight=1      " Minimum height for inactive window
set pumheight=15        " Pop-up menu's line height
set helpheight=12       " Minimum help window height
set previewheight=12    " Completion preview height

if has('folding') && has('vim_starting')
	set foldenable
	set foldmethod=indent
	set foldlevelstart=99
endif

if has('nvim-0.4')
	set signcolumn=yes:1
else
	set signcolumn=yes           " Always show signs column
endif

" 真彩色 - 测试脚本 
" curl -s https://raw.githubusercontent.com/JohnMorales/dotfiles/master/colors/24-bit-color.sh | bash
if $COLORTERM == 'truecolor'
	set termguicolors       " Enable true color
endif

if &term =~# '^screen'
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
if !has('gui_running')
	set t_Co=256
endif
" }}}

" Wildmenu {{{
" --------
if has('wildmenu')
	if ! has('nvim')
		set wildmode=list:longest
	endif
	set wildignorecase
	set wildignore+=.git,.hg,.svn,.stversions,*.pyc,*.spl,*.o,*.out,*~,%*
	set wildignore+=*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store
	set wildignore+=**/node_modules/**,**/bower_modules/**,*/.sass-cache/*
	set wildignore+=application/vendor/**,**/vendor/ckeditor/**,media/vendor/**
	set wildignore+=__pycache__,*.egg-info,.pytest_cache,.mypy_cache/**
	set wildcharm=<C-z>  " substitue for 'wildchar' (<Tab>) in macros
endif
" }}}

" auto spell
" autocmd BufRead,BufNewFile *.go setlocal spell

" if filereadable(expand("~/.dotfiles/.vim/func.vim"))
" 	" source ~/.dotfiles/.vim/func.vim
" endif
