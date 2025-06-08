change = vim.keymap
-- general
change.set("i", "jk", "<Esc>", { noremap = true, silent = true })
change.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
change.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
change.set("n", "<leader>Q", "<cmd>:qa<CR>", { desc = "Close neovim without saving" })
change.set("n", "<Leader>n", "<cmd>:bn<CR>", { noremap = true, silent = true, desc = "Next buffer" })
change.set("n", "<Leader>x", "<cmd>:bd<CR>", { noremap = true, silent = true, desc = "Close buffer" })
change.set("n", "<Leader>b", "<cmd>:enew<CR>", { noremap = true, silent = true, desc = "New buffer" })
-- change.set(
-- 	"n",
-- 	"<Leader>w",
-- 	'<cmd>:w | echo "Saved!" <CR>',
-- 	{ noremap = true, silent = true, desc = "Save current file" }
-- )
vim.keymap.set("n", "<Leader>w", function()
	vim.cmd("w")
	require("noice").api.notify("Saved!", "info", {
		title = "File Saved",
		timeout = 1000, -- 1 saniye
	})
end, {
	noremap = true,
	silent = true,
	desc = "Save current file",
})
change.set("n", "<Leader>q", "<cmd>:wq<CR>", { noremap = true, silent = true, desc = "Save and quit current file" })
change.set(
	"n",
	"<Leader>Q",
	"<cmd>:q!<CR>",
	{ noremap = true, silent = true, desc = "Quit without saving current file" }
)

-- telescope
local builtin = require("telescope.builtin")
change.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
change.set("n", "<leader>fo", builtin.oldfiles, { desc = "Telescope find recently opened files" })
change.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
-- change.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })

-- auto comment shortcut
vim.keymap.set("n", "<leader>/", function()
	require("Comment.api").toggle.linewise.current()
end, { desc = "Toggle comment line" })

vim.keymap.set(
	"v",
	"<leader>/",
	'<ESC><cmd>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>',
	{ desc = "Toggle comment for selection" }
)

-- Makefile
change.set("n", "<leader>m", "<cmd>:!make<CR>", { desc = "Makefile 'make' command" })

-- open notes
-- change.set("n", "<leader>on", ":not<CR>", { desc = "Open notes.norg file" })
change.set("n", "<leader>on", ":e ~/github/new-notes/notes.norg<CR>", { desc = "Open notes.norg file" })
