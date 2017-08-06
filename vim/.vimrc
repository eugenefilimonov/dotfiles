call plug#begin('~/.vim/plugged')
" Make sure you use single quotes
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'altercation/vim-colors-solarized'
Plug 'scrooloose/nerdtree'
Plug 'elixir-lang/vim-elixir'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'tpope/vim-rails'
Plug 'vim-ruby/vim-ruby'
Plug 'flazz/vim-colorschemes'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'sheerun/vim-polyglot'
Plug 'kien/ctrlp.vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'mxw/vim-jsx'
Plug 'vim-syntastic/syntastic'
" Initialize plug
call plug#end()


autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <C-\> :NERDTreeToggle<CR>

let g:solarized_termcolors=256
syntax enable
set background=dark
colorscheme Tomorrow-Night

set number
set backspace=2   " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set noswapfile
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" Use one space, not two, after punctuation.
set nojoinspaces

" configure syntastic syntax checking to check on open as well as save
let g:syntastic_check_on_open=1
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
let g:syntastic_eruby_ruby_quiet_messages =
      \ {"regex": "possibly useless use of a variable in void context"}

