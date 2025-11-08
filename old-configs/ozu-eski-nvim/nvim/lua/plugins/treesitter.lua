return {
	"nvim-treesitter/nvim-treesitter",
	branch = "master",
	lazy = false,
	build = ":TSUpdate",

	-- Zorunlu parser listesi
	ensure_installed = {
		"c",
		"cpp",
		"css",
		"html",
		"json",
		"lua",
		"vim",
		"vimdoc",
		"query",
		"markdown",
		"markdown_inline",
		"norg", -- Neorg temel desteği
		"norg_meta", -- Neorg metadata
		"norg_table", -- Neorg tablolar (eğer hala ayrı parser gerekiyorsa)
	},

	sync_install = false,
	auto_install = true,
	ignore_install = { "javascript" },

	highlight = {
		enable = true, -- Syntax vurgulamayı etkinleştir
		additional_vim_regex_highlighting = false,
	},

	-- Yapılandırma sonrası hook (TSEnable highlight için)
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)

		-- Tree-sitter highlight'ı garanti etmek için
		vim.defer_fn(function()
			vim.cmd("TSEnable highlight") -- Gecikmeli olarak çalıştır
		end, 0)
	end,
}
