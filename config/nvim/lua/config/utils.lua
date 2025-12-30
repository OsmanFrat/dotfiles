function _G.WholeWordReplace()
	local input_str = vim.fn.input("Rename (old/new): ")
	if string.find(input_str, "/") then
		local parts = vim.split(input_str, "/")
		local old, new = parts[1], parts[2]

		-- Tam kelime eşleşmesi için \< ve \> kullanımı
		local escaped_old = vim.fn.escape(old, "/\\")
		local escaped_new = vim.fn.escape(new, "/\\")
		vim.cmd(string.format("%%s/\\<%s\\>/%s/g", escaped_old, escaped_new))
	else
		vim.notify("Invalid format! Use 'old/new'", vim.log.levels.ERROR)
	end
end

-- Keymap örneği (normal modda <leader>rw ile çağırma)
vim.keymap.set("n", "<leader>r", "<cmd>lua WholeWordReplace()<CR>", {
	desc = "Replace",
})

-- disable auto comment
vim.api.nvim_create_augroup("auto_comment", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	group = "auto_comment",
	pattern = "*",
	callback = function()
		vim.opt_local.formatoptions:remove({ "c", "r", "o" })
	end,
})

-- history - undo settings
local undodir = vim.fn.stdpath("config") .. "/home/ozu/.local/share/nvim/undodir/"
if vim.fn.isdirectory(undodir) == 0 then
	vim.fn.mkdir(undodir, "p")
end
vim.opt.undodir = undodir
vim.opt.undofile = true

-- lsp shortcuts
vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { desc = "Lsp quick auto fix" })
vim.keymap.set("n", "<leader>ld", ":Telescope diagnostics<CR>", { desc = "Telescope: Show diagnostics" })
vim.keymap.set("n", "<leader>lb", vim.diagnostic.setqflist, { desc = "Lsp show diagnostics(error, warnings etc.)" })

-- neovide options
if vim.g.neovide then
	vim.g.neovide_scale_factor = 1.0 -- Başlangıç boyutu (1.0 = %100)

	local function change_scale_factor(delta)
		vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + delta
	end

	-- Ctrl + Tekerlek Yukarı → Yakınlaştır
	vim.keymap.set({ "n", "v" }, "<C-ScrollWheelUp>", function()
		change_scale_factor(0.1)
	end, { silent = true })

	-- Ctrl + Tekerlek Aşağı → Uzaklaştır
	vim.keymap.set({ "n", "v" }, "<C-ScrollWheelDown>", function()
		change_scale_factor(-0.1)
	end, { silent = true })

	-- Ctrl + + → Yakınlaştır
	vim.keymap.set({ "n", "v" }, "<C-+>", function()
		change_scale_factor(0.1)
	end, { silent = true })

	-- Ctrl + - → Uzaklaştır
	vim.keymap.set({ "n", "v" }, "<C-->", function()
		change_scale_factor(-0.1)
	end, { silent = true })

	-- Bonus: Ctrl+0 ile sıfırla (Opsiyonel)
	vim.keymap.set("n", "<C-0>", function()
		vim.g.neovide_scale_factor = 1.0
	end, { silent = true })

	-- closing cursor animations
	vim.g.neovide_position_animation_length = 0
	vim.g.neovide_cursor_animation_length = 0.00
	vim.g.neovide_cursor_trail_size = 0
	vim.g.neovide_cursor_animate_in_insert_mode = false
	vim.g.neovide_cursor_animate_command_line = false
	vim.g.neovide_scroll_animation_far_lines = 0
	vim.g.neovide_scroll_animation_length = 0.00
end
