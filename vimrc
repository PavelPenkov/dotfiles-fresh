scriptencoding utf-8
set encoding=utf-8
set nocompatible  " Use Vim settings, rather then Vi settings
set nobackup
set nowritebackup
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
set cursorline
set noswapfile
" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab
set smarttab
" Color scheme
colorscheme ir_black
set background=dark
highlight NonText guibg=#060606
highlight Folded  guibg=#0A0A0A guifg=#9090D0
" Searching
set ignorecase
set smartcase

filetype on
filetype plugin indent on
syntax on

call plug#begin('~/.vim/plugged')
Plug('scrooloose/nerdtree')
Plug 'ctrlpvim/ctrlp.vim'
Plug 'pangloss/vim-javascript'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails'
Plug 'vim-ruby/vim-ruby'
Plug 'gregsexton/gitv', {'on': ['Gitv']}
Plug 'vim-syntastic/syntastic'
Plug 'scrooloose/nerdcommenter'
Plug 'mileszs/ack.vim'
call plug#end()

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

set omnifunc=syntaxcomplete#Complete

augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
augroup END

" Display extra whitespace
set list listchars=tab:»·,trail:·

if executable('ag')
  " Use Ag over Grep
  let g:ackprg = 'ag --vimgrep'
  let g:ctrlp_user_command = 'ag -l -p .ignore --nocolor -g "" %s'
  let g:ctrlp_use_caching = 0
endif

ca Ag Ag!


" Snippets are activated by Shift+Tab
let g:snippetsEmu_key = "<S-Tab>"

" Tab completion options
set wildmode=list:longest,list:full
set complete=.,w,t

" Tags
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'
"

" CtrlP
" let g:ctrlp_dotfiles = 0
" let g:ctrlp_max_files = 0
let g:ctrlp_custom_ignore="node_modules"
let g:ctrlp_regexp = 1

" JavaScript
" au FileType javascript setlocal nolist
au BufNewFile,BufRead *.ejs set filetype=jst
au FileType jst setlocal nolist
" Rake
au BufNewFile,BufRead Capfile set filetype=ruby
" YML
au BufNewFile,BufRead *.yml set ai
" Rubocop autocorret
" au FileType ruby setlocal formatprg=rubocop\ --except\ Style/IndentationWidth\ -a\ --stdin\ foo.rb\ \|\ sed\ '1,/====================/d'
au FileType ruby setlocal formatprg=rubocop\ -a\ --stdin\ foo.rb\ \|\ sed\ '1,/====================/d'

nnoremap <F1> :NERDTreeToggle<CR>
nnoremap <F2> :NERDTreeFind<CR>
" let g:NERDTreeDirArrows=1
" let g:NERDChristmasTree=1

" Buffergator
nnoremap <F3> :BuffergatorToggle<CR>

" Tagbar
nnoremap <Leader>rt :TagbarToggle<CR>

augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * if expand("<afile>")!~#'^\w\+:/' && !isdirectory(expand("%:h")) | execute "silent! !mkdir -p ".shellescape(expand('%:h'), 1) | redraw! | endif
augroup END"

" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif

set re=1

" Syntastic
let g:syntastic_ruby_checkers = ['mri']

let g:syntastic_javascript_checkers = []
let g:syntastic_check_on_wq=0
let g:syntastic_enable_highlighting=1
let g:syntastic_typescript_checkers = ['tsuquyomi'] " You shouldn't use 'tsc' checker.
let g:syntastic_python_checkers=['flake8']
let g:syntastic_python_flake8_args='--ignore=E501,E126,E123,E116,E128,F401'

" NERDCommenter
let NERDSpaceDelims=1

" Tsuquyomi
let g:tsuquyomi_disable_quickfix = 1
" let g:tsuquyomi_disable_default_mappings = 1
autocmd FileType typescript nmap <buffer> <Leader>] <Plug>(TsuDefinition)
autocmd FileType typescript nmap <buffer> <Leader>t <Plug>(TsuGoBack)
