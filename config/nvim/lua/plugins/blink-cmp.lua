return {
	"saghen/blink.cmp",
	dependencies = { "rafamadriz/friendly-snippets" },
	version = "1.*",
	opts = {
		-- Özel keymap tanımlıyoruz
		keymap = {
			["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
			["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
			["<CR>"] = { "accept", "fallback" },
			["<Esc>"] = { "hide", "fallback" },
			["<PageUp>"] = { "scroll_documentation_up", "fallback" },
			["<PageDown>"] = { "scroll_documentation_down", "fallback" },
		},

		appearance = {
			nerd_font_variant = "mono",
		},

		completion = {
			documentation = { auto_show = false },
			-- Aşağıdaki ayarı ekleyin
			preselect = false, -- veya false da olabilir
		},

		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
			preselect = false,
		},

		fuzzy = {
			implementation = "prefer_rust_with_warning",
		},
	},

	opts_extend = { "sources.default" },
}
