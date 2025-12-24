return {
  'akinsho/toggleterm.nvim',
  version = "*",
  opts = {
    -- TEMEL AYARLAR
    direction = "float",
    float_opts = {
      border = "rounded",
      width = function() return math.floor(vim.o.columns * 0.8) end,
      height = function() return math.floor(vim.o.lines * 0.8) end,
    },
    
    -- KRİTİK AYAR: Aynı terminali toggle yapabilmek için
    persist_mode = true,  -- <-- Bu satır önemli!
    close_on_exit = false, -- <-- Kapatıldığında tamamen yok olmasın
  },
  config = function(_, opts)
    require("toggleterm").setup(opts)
    
    -- DOĞRU TOGGLE MAPPING (Terminal objesini kaydet)
    local float_term = require("toggleterm.terminal").Terminal:new({
      direction = "float",
      hidden = true, -- Başlangıçta gizli olsun
    })
    
    vim.keymap.set({"n", "t"}, "<leader>i", function()
      float_term:toggle()  -- Aynı terminali aç/kapa
    end, { desc = "Toggle float terminal" })
  end
}
