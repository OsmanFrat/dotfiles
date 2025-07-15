return {
	cmd = {
		"pyright",
	},
	filetypes = {
		"py",
	},
	root_markers = {
		".git",
	},
	-- settings = {
	-- 	Lua = {
	-- 		diagnostics = {
	-- 			disable = { "missing-parameters", "missing-fields" },
	-- 		},
	-- 	},
	-- },

	single_file_support = true,
	log_level = vim.lsp.protocol.MessageType.Warning,
}
