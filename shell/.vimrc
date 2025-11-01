" General settings
set number
set relativenumber
set tabstop=4
set shiftwidth=4
set expandtab
set nowrap
set incsearch
set hlsearch
set completeopt=menu,menuone,noselect
set showmatch
set autowrite
set mouse=a
set clipboard=unnamedplus

syntax enable

" Normal mode change to kj buttons
inoremap jk <Esc>

" Leader key settings
let mapleader = " "  " Space as the leader key

" ---- WhichKey Shortcuts ----
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>

set termguicolors

" Tokyonight theme settings
let g:tokyonight_style = 'night'
let g:tokyonight_disable_italic_comment = 1
let g:tokyonight_transparent_background = 0 

" Plugins
call plug#begin('~/.vim/plugged')

" C++ dependencies
" Plug 'vim-syntastic/syntastic'
" Plug 'octol/vim-cpp-enhanced-highlight'

" Auto pair brackets/parentheses
" Plug 'jiangmiao/auto-pairs'

" Tokyonight theme
Plug 'ghifarit53/tokyonight-vim'

call plug#end()

" Set the colorscheme
colorscheme tokyonight

