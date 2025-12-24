local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

return {
	cmd = {
		"jdtls",
		"-data",
		workspace_dir,
	},

	filetypes = { "java" },

	root_markers = {
		".git",
		"pom.xml",
		"build.gradle",
		"build.gradle.kts",
	},

	settings = {
		java = {
			eclipse = {
				downloadSources = true,
			},
			maven = {
				downloadSources = true,
			},
			implementationsCodeLens = {
				enabled = true,
			},
			referencesCodeLens = {
				enabled = true,
			},
		},
	},

	single_file_support = false,
}
