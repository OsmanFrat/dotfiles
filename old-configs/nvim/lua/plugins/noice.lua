return {
	"folke/noice.nvim",
	event = "VeryLazy",
	opts = {
		-- Bildirim süresini 1000ms (1 saniye) olarak ayarla
		stage = "static",
		views = {
			notify = {
				timeout = 1000,
			},
		},
	},
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
}
