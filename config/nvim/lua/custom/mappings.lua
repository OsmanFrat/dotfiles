-- ~/.config/nvim/lua/custom/mappings.lua

local M = {}

M.mappings = {
  n = {
    -- <leader>ac kısayolu ile scripti çalıştır
    ["<leader>ac"] = { ":!~/dotfiles/scripts/auto-commit.sh<CR>", "Run auto-commit script" },
  },
}

return M
