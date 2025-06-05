ops = vim.opt
ops.relativenumber = true
ops.number = true
ops.tabstop = 4
ops.clipboard = "unnamedplus"
ops.shiftwidth = 2
ops.expandtab = true
ops.ignorecase = true
ops.smartcase = true
ops.incsearch = true
ops.hlsearch = true
ops.completeopt = "menu,menuone,noselect,noinsert"
ops.showmatch = true
ops.autowrite = true
ops.autochdir = true
ops.mouse = a
ops.timeoutlen = 500
ops.showtabline = 0
ops.cursorline = true
ops.termguicolors = true
ops.scrolloff = 15
vim.g.mapleader = " "  -- <leader> tuşunu boşluk (space) yapar
vim.g.maplocalleader = " "  -- <localleader> için de aynı (opsiyonel)


-- theme
vim.cmd([[colorscheme monokai-pro]])
