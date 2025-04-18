" General settings
set number
set relativenumber
set tabstop=4
set shiftwidth=4
set expandtab
set nowrap
set ignorecase
set smartcase
set incsearch
set hlsearch
set completeopt=menu,menuone,noselect,noinsert
set showmatch
set autowrite
set mouse=a
set timeoutlen=500
set showtabline=0
set cursorline
set clipboard=unnamedplus

" History settings
set undofile           " Undo dosyasını kaydet
set undodir=~/.vim/undodir  " Undo geçmişi için özel bir dizin belirtin
set undolevels=1000    " Geri alma geçmişi için yeterince büyük bir limit
set undoreload=10000   " Dosya büyüklüğüne göre geri alma seviyesini artır

" Auto save for each change on current file
au BufWritePost * :silent! write

syntax enable

set termguicolors

" Normal mode change to jk buttons
inoremap jk <Esc>

" Clear seach highlight until next search
nnoremap <silent> <esc> :nohl<return><esc>

" Setting semicolor(;) as colon(:)
nnoremap ; :
vnoremap ; :

" Plugins
call plug#begin('~/.vim/plugged')

" Home page/dashboard for nvim
Plug 'goolord/alpha-nvim'
Plug 'nvim-tree/nvim-web-devicons'

" Toggle terminal
Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}

" C++ dependencies
Plug 'vim-syntastic/syntastic'
Plug 'octol/vim-cpp-enhanced-highlight'

" Auto pair brackets/parentheses
Plug 'jiangmiao/auto-pairs'

" Tokyonight theme
Plug 'ghifarit53/tokyonight-vim'

" Cheat sheet for shortcuts (Which Key)
Plug 'liuchengxu/vim-which-key'

" Tree sitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" FZF + Neovim entegrasyonu
Plug 'junegunn/fzf', { 'do': './install --bin', 'dir': '~/.fzf' }
Plug 'junegunn/fzf.vim'

" Nerdtree
Plug 'preservim/nerdtree' 

" Coc - lsp
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

" Coc.nvim settings
set updatetime=300
set signcolumn=auto:1

autocmd VimEnter * silent! CocStart

" Auto suggests shortcut for tab button in Coc.nvim
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

set pumheight=8
set pumwidth=10

" Fzf.vim settings
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, 
  \   {'source': 'fd --type f --hidden --exclude venv --exclude node_modules --exclude .git'},
  \   <bang>0)


" Enable treesitter
autocmd FileType python lua vim.treesitter.start()

" Alpha.nvim / dashboard settings
lua <<EOF
local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

-- Basit başlık
dashboard.section.header.val = {
"⡆⣿⣿⣦⠹⣳⣳⣕⢅⠈⢗⢕⢕⢕⢕⢕⢈⢆⠟⠋⠉⠁⠉⠉⠁⠈⠼⢐⢕⢽",
"⡗⢰⣶⣶⣦⣝⢝⢕⢕⠅⡆⢕⢕⢕⢕⢕⣴⠏⣠⡶⠛⡉⡉⡛⢶⣦⡀⠐⣕⢕",
"⡝⡄⢻⢟⣿⣿⣷⣕⣕⣅⣿⣔⣕⣵⣵⣿⣿⢠⣿⢠⣮⡈⣌⠨⠅⠹⣷⡀⢱⢕",
"⡝⡵⠟⠈⢀⣀⣀⡀⠉⢿⣿⣿⣿⣿⣿⣿⣿⣼⣿⢈⡋⠴⢿⡟⣡⡇⣿⡇⡀⢕",
"⡝⠁⣠⣾⠟⡉⡉⡉⠻⣦⣻⣿⣿⣿⣿⣿⣿⣿⣿⣧⠸⣿⣦⣥⣿⡇⡿⣰⢗⢄",
"⠁⢰⣿⡏⣴⣌⠈⣌⠡⠈⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣬⣉⣉⣁⣄⢖⢕⢕⢕",
"⡀⢻⣿⡇⢙⠁⠴⢿⡟⣡⡆⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣵⣵⣿",
"⡻⣄⣻⣿⣌⠘⢿⣷⣥⣿⠇⣿⣿⣿⣿⣿⣿⠛⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
"⣷⢄⠻⣿⣟⠿⠦⠍⠉⣡⣾⣿⣿⣿⣿⣿⣿⢸⣿⣦⠙⣿⣿⣿⣿⣿⣿⣿⣿⠟",
"⡕⡑⣑⣈⣻⢗⢟⢞⢝⣻⣿⣿⣿⣿⣿⣿⣿⠸⣿⠿⠃⣿⣿⣿⣿⣿⣿⡿⠁⣠",
"⡝⡵⡈⢟⢕⢕⢕⢕⣵⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣶⣿⣿⣿⣿⣿⠿⠋⣀⣈⠙",
"⡝⡵⡕⡀⠑⠳⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠛⢉⡠⡲⡫⡪⡪⡣",
}

-- Sizin butonlarınız (değişmeden)
dashboard.section.buttons.val = {
  dashboard.button("e", "  New file", ":ene<CR>"),
  dashboard.button("f", "  Search", ":Files<CR>"),
  dashboard.button("r", "󱋡  Recent files", ":History<CR>"),
  dashboard.button("c", "  Config", ":e ~/.config/nvim/init.vim<CR>"),
  dashboard.button("q", "󰈆  Exit", ":qa<CR>"),
}

-- Footer kaldırıldı (hata veriyordu)
dashboard.section.footer.val = ""

-- Minimal setup
alpha.setup(dashboard.config)
EOF

" Basit autocommand
autocmd VimEnter * if argc() == 0 && empty(v:this_session) && line('$') == 1 && getline(1) == '' | lua require('alpha').start() | endif


" Gelişmiş otomatik başlatma
autocmd User AlphaReady set showtabline=0 | set laststatus=0
autocmd User AlphaClosed set showtabline=0 | set laststatus=0
autocmd VimEnter *
  \ if !argc() && 
  \   vim.fn.empty(vim.fn.argv()) == 1 &&
  \   vim.fn.line('$') == 1 && 
  \   vim.fn.getline(1) == ''
  \ | lua require'alpha'.start()
  \ | endif

" Close auto comment line in new line
augroup auto_comment
  autocmd!
  autocmd FileType * setlocal formatoptions-=cro
augroup END

" Sadece gerçek dosyaları gösteren FZF geçmişi
command! History call fzf#run({
  \ 'source':  filter(v:oldfiles, 'filereadable(expand(v:val))'),
  \ 'sink':    'e',
  \ 'options': '--reverse --tiebreak=index',
  \ 'window':  { 'width': 0.9, 'height': 0.6 }
  \})

set shada='200,f1  "

" NERDTree settings
let NERDTreeShowHidden=1
let NERDTreeQuitOnOpen=1

" Rename function
function! WholeWordReplace()
  let input_str = input('Rename (old/new): ')
  if input_str =~# '/'
    let [old, new] = split(input_str, '/')
    execute '%s/\<'.escape(old, '/\').'\>/'.escape(new, '/\').'/g'
  else
    echo "Invalid format! You have to enter like this: 'old/new"
  endif
endfunction

" Comment toggle
function! ToggleComment() range
  let l:comment_map = {
    \ 'python': '#',
    \ 'vim': '"',
    \ 'c': '//',
    \ 'cpp': '//',
    \ 'javascript': '//',
    \ 'sh': '#',
    \ 'lua': '--',
    \ 'html': '<!--',
    \ 'css': '/*',
    \ 'lips': ';;',
    \ 'elips': ';;',
    \ 'scheme': ';;',
    \ }

  let l:cmt = get(l:comment_map, &filetype, '#')
  let l:end_cmt = &filetype =~? 'html' ? '-->' : &filetype =~? 'css' ? '*/' : ''
  
  " Seçili satırlar için
  for lnum in range(a:firstline, a:lastline)
    let l:line = getline(lnum)
    let l:indent = matchstr(l:line, '^\s*') " Girintiyi al
    
    if l:line =~# '^\s*'.l:cmt
      " Yorumu kaldır (girintiyi koru)
      let l:new_line = substitute(l:line, l:cmt.'\s\?', '', '')
      if l:end_cmt != ''
        let l:new_line = substitute(l:new_line, '\s*'.l:end_cmt.'\s*$', '', '')
      endif
      call setline(lnum, l:indent.trim(l:new_line))
    elseif l:line =~# '\S'
      " Yorum ekle (girintiyi koru)
      let l:new_line = l:cmt.' '.trim(l:line[len(l:indent):])
      if l:end_cmt != ''
        let l:new_line .= ' '.l:end_cmt
      endif
      call setline(lnum, l:indent.l:new_line)
    endif
  endfor
endfunction

" terminal test
lua << EOF
require("toggleterm").setup({
  size = function(term)
    if term.direction == "horizontal" then
      return 10  -- Yükseklik (satır sayısı)
    elseif term.direction == "vertical" then
      return vim.o.columns * 1.0  -- Genişlik (sütun yüzdesi)
    end
  end,
  open_mapping = nil, -- Haritayı elle ayarladığımız için nil
  direction = "float", -- Pencereyi float (yüzen) modda aç
  float_opts = {
    border = "single", -- Kenarlık stili
    width = function() return math.floor(vim.o.columns * 0.96) end,  -- Genişlik (%80)
    height = function() return math.floor(vim.o.lines * 0.9) end,    -- Yükseklik (%80)
    winblend = 0,     -- Şeffaflık
  }
})
EOF


" Tokyonight theme settings
let g:tokyonight_style = 'night'
let g:tokyonight_disable_italic_comment = 1
let g:tokyonight_transparent_background = 0 

" Set the colorscheme
colorscheme tokyonight

" Leader key settings
let mapleader = " "  " Space as the leader key

" ----> WhichKey Shortcuts <----
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
let g:which_key_map =  {}

" -- Python --
nnoremap <silent> <Leader>pp :w<CR>:!python %<CR>
nnoremap <silent> <Leader>pe :!python -m venv venv<CR>
nnoremap <silent> <Leader>ps :!source venv/bin/activate<CR>

" Reload init.vim
nnoremap <silent> <leader>R :source /home/ozu/.config/nvim/init.vim<CR>

" -- Fzf --
nnoremap <silent> <Leader>ff :Files<CR>
nnoremap <silent> <Leader>e :NERDTreeToggle<CR>
nnoremap <silent> <Leader>fo :History<CR>

" -- Buffers -- 
nnoremap <silent> <Leader>n :bn<CR>
nnoremap <silent> <Leader>x :bd<CR>
nnoremap <silent> <Leader>b :enew<CR>

" -- LSP --
nmap <silent> <leader>ld <Plug>(coc-definition)
nnoremap <silent> <leader>lr :call CocActionAsync('references')<CR>
nmap <silent> <leader>lh <Plug>(coc-diagnostic-info)

" -- vim essential shortcuts like :w etc. --
nnoremap <leader>w :w<CR>
nnoremap <leader>q :wq<CR>
nnoremap <leader>Q :q!<CR>

" -- Rename --
nnoremap <leader>r :call WholeWordReplace()<CR>

" -- Comment toggle
nnoremap <leader>/ :call ToggleComment()<CR>
vnoremap <leader>/ :call ToggleComment()<CR>

" Super+i için terminal toggle
nnoremap <silent> <leader>i <cmd>lua require("toggleterm").toggle()<CR>
tnoremap <silent> <leader>i <C-\><C-n><cmd>lua require("toggleterm").toggle()<CR>

" ---> Setting shortcuts to vim-whichkey plugin
let g:which_key_map.R = 'vim reload'

let g:which_key_map.p = {
      \ 'name' : '+python',
      \ 'p' : 'Run current python script',
      \ 'e' : 'Create python venv',
      \ 's' : 'Source python venv',
      \ }

let g:which_key_map.f = {
    \ 'name' : '+fzf',
    \ 'f' : 'Search in current dir',
    \ 'o' : 'Recently opened files',
    \ }

let g:which_key_map.e = 'toggle nerdtree'

let g:which_key_map.n = 'Next buffer'
let g:which_key_map.x = 'Close buffer'
let g:which_key_map.b = 'New blank buffer'

let g:which_key_map.l = {
     \ 'name' : '+lsp',
     \ 'd' : 'Show definition',
     \ 'r' : 'Show reference',
     \ 'h' : 'Show errors',
     \ }

let g:which_key_map.r = 'Rename'
let g:which_key_map['/'] = 'Comment toggle'
let g:which_key_map.i = 'Terminal toggle'
let g:which_key_map.w = 'Save'
let g:which_key_map.q = 'Save and quit'
let g:which_key_map.Q = 'Quit without save'


call which_key#register('<Space>', "g:which_key_map")


