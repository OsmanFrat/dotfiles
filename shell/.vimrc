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


" Normal mode change to kj buttons
inoremap jk <Esc>

syntax enable

" set leader key to space
let mapleader = "\<Space>"

set termguicolors

" Tokyonight theme settings
let g:tokyonight_style = 'night'
let g:tokyonight_disable_italic_comment = 1
let g:tokyonight_transparent_background = 0 

" Which key - cheat sheet when leader button pressed
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>

" Plugins
call plug#begin('~/.vim/plugged')

" C++ dependencies
Plug 'vim-syntastic/syntastic'
Plug 'octol/vim-cpp-enhanced-highlight'

" Auto pair brackets/parentheses
Plug 'jiangmiao/auto-pairs'

" Tokyonight theme
Plug 'ghifarit53/tokyonight-vim'

" Cheat sheet for shortcuts when pressed space(leader-key)
Plug 'liuchengxu/vim-which-key'

call plug#end()

" Changing the theme
colorscheme tokyonight
