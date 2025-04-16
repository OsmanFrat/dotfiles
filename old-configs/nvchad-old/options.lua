require "nvchad.options"

-- add yours here!

local o = vim.o
o.cursorlineopt = "both" -- to enable cursorline!
o.relativenumber = true
o.foldmethod = "manual"
o.foldexpr = "nvim_treesitter#foldexpr()"
