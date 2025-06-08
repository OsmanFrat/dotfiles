return {
	"folke/noice.nvim",
	event = "VeryLazy",
	opts = {
		-- Bildirim süresini 1000ms (1 saniye) olarak ayarla
		views = {
			notify = {
				timeout = 1000,
			},
		},
		-- İsterseniz routes kısmında özel bir timeout da belirleyebilirsiniz
		routes = {
			{
				filter = { event = "notify" },
				opts = { timeout = 1000 },
			},
		},
	},
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
}
