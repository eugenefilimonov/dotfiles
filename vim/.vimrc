call plug#begin('~/.vim/plugged')
" Make sure you use single quotes
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-dispatch'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'kien/ctrlp.vim'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'vim-syntastic/syntastic'
Plug 'sheerun/vim-polyglot'
Plug 'gabesoft/vim-ags'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tmux-plugins/vim-tmux'
Plug 'hzchirs/vim-material'
Plug 'gilgigilgil/anderson.vim'
Plug 'danilo-augusto/vim-afterglow'
Plug 'dense-analysis/ale'
" Initialize plug
call plug#end()

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
map <C-\> :NERDTreeToggle<CR>



map <leader>a  <Plug>(coc-codeaction-selected)
map <leader>a  <Plug>(coc-codeaction-selected)

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
set clipboard=unnamed  " yank to clipboard

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" Use one space, not two, after punctuation.
set nojoinspaces

" Set ale signal errors and warnings
let g:ale_sign_error = '●'
let g:ale_sign_warning = '.'

" Set specific ale linters
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'ruby': ['rubocop'],
\}

" Only run linters named in ale_linters settings.
let g:ale_linters_explicit = 1

" Ale Airline integration
let g:airline#extensions#ale#enabled = 1

" Disable ALE auto highlights
let g:ale_set_highlights = 0

" Defined ale filters for auto save feature
let b:ale_fixers = ['rubocop', 'eslint']

" Disable linter on enter
let g:ale_lint_on_enter = 0

" Show lint error in status line
function! LinterStatus() abort
  let l:counts = ale#statusline#Count(bufnr(''))    let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors    return l:counts.total == 0 ? 'OK' : printf(
        \   '%d⨉ %d⚠ ',
        \   all_non_errors,
        \   all_errors
        \)
endfunction

set statusline+=%=
set statusline+=\ %{LinterStatus()}

" map e to next lint error
nmap <silent> <C-e> <Plug>(ale_next_wrap)

" auto fix linters issues on save
let g:ale_fix_on_save = 1

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_global_extensions = ['coc-solargraph']

" spell check settings
set spell
hi clear SpellBad
hi SpellBad cterm=underline,bold

set termguicolors
set background=dark
colorscheme vim-material

let g:airline_theme = 'material'

nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

set syntax=on
