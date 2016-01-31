" # Plugins
" - Vundle
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'Shougo/unite.vim'
Plugin 'Shougo/vimproc.vim'
Plugin 'Valloric/MatchTagAlways'
Plugin 'Valloric/YouCompleteMe'
Plugin 'VundleVim/Vundle.vim'
Plugin 'Yggdroot/indentLine'
Plugin 'airblade/vim-gitgutter'
Plugin 'benmills/vimux'
Plugin 'bling/vim-airline'
Plugin 'chriskempson/base16-vim'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'edkolev/tmuxline.vim'
Plugin 'godlygeek/tabular'
Plugin 'jiangmiao/auto-pairs'
Plugin 'plasticboy/vim-markdown'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/syntastic'
Plugin 'sukima/xmledit'
Plugin 'tpope/vim-surround'
Plugin 'unterzicht/vim-virtualenv'

" syntax files
Plugin 'cespare/vim-toml'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'othree/html5.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'rust-lang/rust.vim'

call vundle#end()
filetype plugin indent on

" - YouCompleteMe
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_rust_src_path = $HOME."/rust/nightly/src"

autocmd FileType rust nnoremap gd :YcmCompleter GoTo<CR>

" - airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme = "base16"

set laststatus=2
set noshowmode

" - auto-pairs
let g:AutoPairsFlyMode = 1

" - base-16
let base16colorspace = 256
colorscheme base16-default
set background=dark

" - exheres
let g:exheres_author_name="Jorge Aparicio"

" - unite
call unite#filters#matcher_default#use(['matcher_fuzzy'])

" - xmledit
let g:xmledit_enable_html = 1

" # Visual enhancement
" - syntax highlighting
syntax on

" - show line numbers
set number
set relativenumber

" - keep cursor vertically centered
set scrolloff=99

" - show line length limit
set textwidth=80
set colorcolumn=81

autocmd FileType exheres-0 setlocal textwidth=100 colorcolumn=101
autocmd FileType exlib setlocal textwidth=100 colorcolumn=101
autocmd FileType markdown setlocal textwidth=100 colorcolumn=101
autocmd FileType rust setlocal textwidth=100 colorcolumn=101

" - highlight trailing spaces
highlight TrailingSpaces ctermbg=1

match TrailingSpaces /\s\+$/
au InsertEnter * match TrailingSpaces /\s\+$/
au InsertLeave * match TrailingSpaces /\s\+$/

" # Key mapping

" - remap leader
let mapleader = "\<Space>"
let maplocalleader = "\<Space>"

" - accessible delete in insert mode
inoremap <C-l> <Delete>

" - clear current search highlight
nnoremap <silent> <CR> :noh<CR><CR>

" - clipboard shortcuts
nmap <leader>P "+P
nmap <leader>p "+p
vmap <leader>y "+y

" - remove the ex mode
map Q <nop>

" - sudo write
cmap w!! w !sudo tee > /dev/null %

" - unite shortcuts
nnoremap <leader>b :Unite -no-split buffer<cr>
nnoremap <leader>r :Unite -start-insert file_rec/async:!<CR>

" # File management
set autoread
set noswapfile
set viminfo=""

" # Indentation
set autoindent
set expandtab
set shiftwidth=2
set tabstop=2

au FileType markdown setl sw=4 ts=4
au FileType rust setl sw=4 ts=4

" # Search enhancements
set hlsearch
set ignorecase
set incsearch
set nowrapscan
set smartcase

" # Spell checking
set spell spelllang=en_us
