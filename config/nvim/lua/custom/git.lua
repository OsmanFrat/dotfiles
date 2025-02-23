local M = {}

M.auto_commit = function()
  -- Mevcut dosyanın bulunduğu dizini al
  local current_dir = vim.fn.expand("%:p:h")

  -- Terminalde shell script'i çalıştır
  local cmd = "cd " .. current_dir .. " && ~/scripts/git-auto-commit.sh"
  os.execute(cmd)

  print("🚀 Git işlemi tamamlandı!")
end

return M
