return {
	"nvim-neorg/neorg",
	lazy = false,
	version = "*",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("neorg").setup({
			load = {
				["core.defaults"] = {}, -- Temel özellikler
				["core.concealer"] = {
                  init_open_folds = "always",
                }, -- İtalik, kalın, alt çizgi vb. görsel öğeler
				["core.dirman"] = { -- Notların dizin yönetimi
					config = {
						workspaces = {
							notes = "~/github/new-notes/",
						},
						default_workspace = "notes",
						index = "notes.norg", -- Ana dizin dosyası
					},
				},
			},
		})
	end,
}
