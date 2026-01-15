return {
	cmd = {
		"omnisharp",
		"--languageserver",
		"--hostPID",
		tostring(vim.fn.getpid()),
	},

	filetypes = {
		"cs",
		"csproj",
		"sln",
	},

	root_markers = {
		".git",
		"*.sln",
		"*.csproj",
		"Directory.Build.props",
		"Directory.Build.targets",
		"global.json",
	},

	settings = {
		omnisharp = {
			enable_editorconfig_support = true,
			enable_ms_build_load_projects_on_demand = false,
			enable_roslyn_analyzers = true,
			organize_imports_on_format = true,
			enable_import_completion = true,
			sdk_include_prereleases = true,
		},
	},

	single_file_support = true,
	log_level = vim.lsp.protocol.MessageType.Warning,
}
