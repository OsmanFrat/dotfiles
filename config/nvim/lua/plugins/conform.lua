return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			python = { "black" },
			lua = { "stylua" },
			c = {
				{
					"clang_format",
					args = { "-style=/home/ozu/.config/.clang-format" }, -- .clang-format dosyasını kullan
				},
			},
			cpp = {
				{ "clang_format", args = { "-style=file" } },
			},
		},
		format_on_save = {
			timeout_ms = 500,
			lsp_fallback = true,
		},
	},
}
