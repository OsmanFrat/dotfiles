return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			python = { "black" }, -- önce isort, sonra black
			lua = { "stylua" },
			c = { "clang_format" },
			cpp = { "clang_format" },
		},
		-- kaydederken otomatik formatla
		format_on_save = {
			timeout_ms = 500,
			lsp_fallback = true,
		},
	},
}
