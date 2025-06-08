require("core.lazy")
require("core.lsp")
require("config.options")
require("config.keymaps")
require("config.utils")

-- neovide test
-- Neovide'da Ctrl + Fare Tekerleği ile yakınlaştırma
if vim.g.neovide then
	vim.g.neovide_scale_factor = 1.0 -- Başlangıç boyutu (1.0 = %100)

	-- Ctrl + Tekerlek Yukarı → Yakınlaştır
	vim.keymap.set({ "n", "v" }, "<C-ScrollWheelUp>", function()
		vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1
	end, { silent = true })

	-- Ctrl + Tekerlek Aşağı → Uzaklaştır
	vim.keymap.set({ "n", "v" }, "<C-ScrollWheelDown>", function()
		vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1
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
