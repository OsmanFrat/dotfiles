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

-- toggle todo list
local todo_win_id = nil

local function toggle_todo_file()
	local cwd = vim.fn.getcwd()
	local todo_path = cwd .. "/todo.md"
	local new_file = false

	-- Dosya yoksa oluştur
	if vim.fn.filereadable(todo_path) == 0 then
		local f = io.open(todo_path, "w")
		if f then
			f:write("# TODO\n\n- [ ] ")
			f:close()
			new_file = true
		end
	end

	-- Eğer pencere zaten açıksa kapat
	if todo_win_id and vim.api.nvim_win_is_valid(todo_win_id) then
		vim.api.nvim_win_close(todo_win_id, true)
		todo_win_id = nil
		return
	end

	-- Buffer oluştur
	local buf = vim.fn.bufadd(todo_path)
	vim.fn.bufload(buf)

	-- Floating window boyutu
	local width = math.floor(vim.o.columns * 0.8)
	local height = math.floor(vim.o.lines * 0.8)
	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)

	-- Floating window aç
	todo_win_id = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		row = row,
		col = col,
		width = width,
		height = height,
		style = "minimal",
		border = "rounded",
	})

	-- Dosya tipi belirle
	vim.bo[buf].filetype = "markdown"

	-- Eğer dosya yeni oluşturulduysa: imleci hareket ettir ve insert moda geç (planla)
	if new_file then
		vim.schedule(function()
			vim.api.nvim_win_set_cursor(todo_win_id, { 3, 7 }) -- 3. satır, 5. sütun ( - [ ] 'in sonu gibi)
			vim.cmd("startinsert")
		end)
	end
end

-- <leader>o tuşuna atama
vim.keymap.set("n", "<leader>oo", toggle_todo_file, { desc = "Toggle todo" })

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

-- go to normal mode when lsp suggesting window closed with esc
vim.api.nvim_create_autocmd("User", {
	pattern = "BlinkCmpMenuClosed", -- blink.cmp'nin menü kapandığında tetiklediği event
	callback = function()
		if vim.fn.mode() == "i" then -- Sadece Insert moddaysa
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
		end
	end,
})
