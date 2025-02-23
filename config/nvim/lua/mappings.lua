require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("i", "JK", "<ESC>")

-- F5 tuşu ile VimtexCompile komutunu çalıştırma
map('n', '<F5>', ':VimtexCompile<CR>', { noremap = true, silent = true })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
