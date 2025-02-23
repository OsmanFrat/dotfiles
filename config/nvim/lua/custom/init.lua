local git = require("custom.git")

vim.api.nvim_create_user_command("GitAutoCommit", git.auto_commit, {})
vim.keymap.set("n", "<leader>gc", git.auto_commit, { desc = "Git Auto Commit & Push" })
